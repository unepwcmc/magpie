class CartodbPolygonUploadWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :magpie

  def perform(database, polygon_upload_id)
    Apartment::Database.switch(database)
    @polygon_upload = PolygonUpload.find(polygon_upload_id)
    @polygon_upload.upload_to_cartodb
    @polygon_upload.create_polygons_from_cartodb
    @polygon_upload.cleanup
  end
end
