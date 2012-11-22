class PolygonsController < ApplicationController

  def create
    aoi = AreaOfInterest.find(request.path_parameters[:area_of_interest_id])
    @polygon = aoi.polygons.create(
      :geometry => params[:geometry].to_json
    )
    render 'polygons/show', :status => 201
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    @polygon.update_attributes(
      :geometry => params[:geometry],
      :area_of_interest_id => params[:area_of_interest_id]
    )
    render 'polygons/show'
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    render
  end

  def destroy
    @polygon = Polygon.find(request.path_parameters[:id])
    if @polygon.destroy
      head :ok
    else
      head :unauthorized
    end
  end
end
