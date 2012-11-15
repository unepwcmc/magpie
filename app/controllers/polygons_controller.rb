class PolygonsController < ApplicationController

  def create
    area_of_interest = AreaOfInterest.find(request.path_parameters[:area_of_interest_id])
    @polygon = area_of_interest.polygons.create(:geometry => params[:geometry])
    render
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    @polygon.update_attributes(params)
    render :json => @polygon
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    render :json => @polygon
  end

end
