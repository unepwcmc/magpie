class PolygonsController < ApplicationController
  respond_to :json

  def show
    @polygon = Polygon.find(params[:id])
    respond_with(@polygon)
  end

  def new_upload_form
    render :layout => false
  end

  def create
    area_of_interest = AreaOfInterest.find(params[:area_of_interest_id])
    @polygon = area_of_interest.polygons.new(params[:polygon])
    flash[:notice] = 'Polygon was successfully created.' if @polygon.save
    respond_with(@polygon)
  end

  def create_from_file
    uploaded_io = params[:file]
    content = uploaded_io.read

    render json: "{\"filename\":\"#{uploaded_io.original_filename}\", content: \"#{content}\"}"
  end

  def update
    @polygon = Polygon.find(params[:id])
    flash[:notice] = 'Polygon was successfully updated.' if @polygon.update_attributes(params[:polygon])
    respond_with(@polygon)
  end

  def destroy
    @polygon = Polygon.find(params[:id])
    @polygon.destroy
    flash[:notice] = 'Polygon was successfully destroyed.'
    respond_with(@polygon)
  end
end
