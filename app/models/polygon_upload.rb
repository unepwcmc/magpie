class PolygonUpload < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :filename, :message, :state
  belongs_to :area_of_interest

  def self.create_with_file(options)
    polygon_upload = PolygonUpload.new(area_of_interest_id: options[:area_of_interest_id])
    polygon_upload.state = "Not yet uploaded"

    polygon_upload.filename = "tmp/#{polygon_upload.generate_file_stamp}_#{options[:file].original_filename}"
    File.open(polygon_upload.filename, 'w') { |f| f.write(options[:file].read) }

    polygon_upload.save
    return polygon_upload
  end

  def generate_file_stamp
    "#{self.area_of_interest_id}_#{Time.now.to_i}"
  end

  def destroy_and_remove_file
    File.delete(self.filename)
    self.destroy
  end

  def upload_to_cartodb
    require 'httmultiparty'
    file = File.open(self.filename)
    # TODO make cartodb stuff into app variables
    response = HTTMultiParty.post("#{CARTODB_CONFIG[:host]}/api/v1/imports", :query => {:file => file, :api_key => CARTODB_CONFIG['api_key']})
    upload_result = JSON.parse(response.body)
    if upload_result["success"]
      self.state = "uploaded"
      until self.table_name.present? do
        sleep(2)
        self.check_cartodb_import_state upload_result['item_queue_id']
      end
    end
  end

  def check_cartodb_import_state item_queue_id
    response = HTTParty.get("#{CARTODB_CONFIG[:host]}/api/v1/imports/#{item_queue_id}", :query => {:api_key => CARTODB_CONFIG['api_key']})
    import_status = JSON.parse(response.body)
    if import_status['success']
      self.table_name = import_status['table_name']
      self.state = "in cartodb"
      self.save
    end
  end

  def create_polygons_from_cartodb
  end
end
