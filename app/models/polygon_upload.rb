class PolygonUpload < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :filename, :message, :state
  belongs_to :area_of_interest

  NOT_YET_UPLOADED_STATE = "Not yet uploaded"
  UPLOADING_STATE = "Uploading"
  UPLOADED_STATE = "Uploaded"
  PROCESSING_STATE = "Processing"
  IMPORTING_STATE = "Importing"
  PARTIAL_STATE = "Imported with some errors"
  ERROR_STATE = "Unable to import any polygons"
  SUCCESS_STATE = "Successful import"
  NOTHING_TO_DO_STATE = "No polygons found to import"

  FINISHED_STATES = [PARTIAL_STATE, ERROR_STATE, SUCCESS_STATE, NOTHING_TO_DO_STATE]

  def self.create_with_file(options)
    polygon_upload = PolygonUpload.new(area_of_interest_id: options[:area_of_interest_id])
    polygon_upload.state = NOT_YET_UPLOADED_STATE

    # Copy file to tmp directory
    polygon_upload.filename = "#{Rails.root}/tmp/#{polygon_upload.generate_file_stamp}_#{options[:file].original_filename}"
    FileUtils.cp options[:file].tempfile.path, polygon_upload.filename

    polygon_upload.save
    return polygon_upload
  end

  def generate_file_stamp
    "#{self.area_of_interest_id}_#{Time.now.to_i}"
  end

  def cleanup
    File.delete(self.filename)
    delete_table_from_cartodb if table_name
  end

  def delete_table_from_cartodb
    response = HTTParty.delete("#{CARTODB_CONFIG['host']}/api/v1/tables/#{table_name}", {query: {api_key: CARTODB_CONFIG['api_key']}})
  end

  def upload_to_cartodb
    require 'httmultiparty'
    file = File.open(self.filename)
    self.state = UPLOADING_STATE
    self.save
    # TODO make cartodb stuff into app variables
    response = HTTMultiParty.post("#{CARTODB_CONFIG['host']}/api/v1/imports", :query => {:file => file, :api_key => CARTODB_CONFIG['api_key']})
    upload_result = JSON.parse(response.body)
    if upload_result["success"]
      self.state = UPLOADED_STATE
      self.save
      until self.table_name.present? do
        sleep(2)
        self.check_cartodb_import_state upload_result['item_queue_id']
      end
    end
  end

  def check_cartodb_import_state item_queue_id
    response = HTTParty.get("#{CARTODB_CONFIG['host']}/api/v1/imports/#{item_queue_id}", :query => {:api_key => CARTODB_CONFIG['api_key']})
    import_status = JSON.parse(response.body)
    if import_status['success']
      self.table_name = import_status['table_name']
      self.state = PROCESSING_STATE
      self.save
    end
  end

  def create_polygons_from_cartodb
    self.state = IMPORTING_STATE
    self.save
    polygon_sql = "SELECT ST_AsGeoJson(the_geom) as geo_json FROM #{self.table_name};"
    response = HTTParty.get("#{CARTODB_CONFIG['host']}/api/v2/sql", {query: {q: polygon_sql, api_key: CARTODB_CONFIG['api_key']}})
    puts response.body
    successes = []
    errors = []
    JSON.parse(response.body)['rows'].each do |feature|
      begin
        feature = JSON.parse(feature["geo_json"])
        geo_json = feature["coordinates"]
        if feature['type'] == 'MultiPolygon'
          geo_json = geo_json[0]
        elsif feature['type'] != 'Polygon'
          errors.push("feature type #{feature['type']} not supported")
        end
        geo_json = {type: 'Polygon', coordinates:geo_json}
        polygon = Polygon.create(geometry: geo_json, area_of_interest_id: self.area_of_interest_id)
        successes.push polygon
      rescue TypeError => e
        errors.push(e.message)
      rescue JSON::ParserError => e
        errors.push(e.message)
      end
    end
    if errors.length > 0
      if successes.length > 0
        self.state = PARTIAL_STATE
      else
        self.state = ERROR_STATE
      end
    elsif successes.length > 0
      self.state = SUCCESS_STATE
    else
      self.state = NOTHING_TO_DO_STATE
    end
    successes.each do |polygon|
      self.message ||= ""
      self.message += "Imported polygon #{polygon.id}\n"
    end
    errors.each do |error|
      self.message ||= ""
      self.message += "#{error}\n"
    end
    self.save
  end
end
