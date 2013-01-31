class PolygonUploadsController < ApplicationController
  respond_to :json

  def show
    @polygon_upload = PolygonUpload.find(params[:id])
    respond_with(@polygon_upload)
  end
end
