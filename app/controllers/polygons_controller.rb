class PolygonsController < ApplicationController

  def create
    aoi = AreaOfInterest.find(request.path_parameters[:area_of_interest_id])
    @polygon = aoi.polygons.create(:geometry => params[:geometry])
    render 'polygons/show', :status => 201
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    @polygon.update_attributes(params)
    render 'polygons/show'
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    render
  end

end
