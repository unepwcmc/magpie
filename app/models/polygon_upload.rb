class PolygonUpload < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :filename, :message, :state
  belongs_to :area_of_interest

  def self.create_with_file(options)
    polygon_upload = PolygonUpload.new(area_of_interest_id: options[:area_of_interest_id])

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
end
