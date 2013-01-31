class CartodbPolygonUploadWorker
  include Sidekiq::Worker

  def perform(polygon_upload_id)
    @polygon_upload = PolygonUpload.find(polygon_upload_id)
    @polygon_upload.upload_to_cartodb
    @polygon_upload.create_polygons_from_cartodb
    @polygon_upload.destroy_and_cleanup
  end
end
