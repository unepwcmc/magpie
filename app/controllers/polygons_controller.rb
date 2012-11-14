class PolygonsController < ApplicationController

  def create
    @polygon = Polygon.create(params)
    render :json => @polygon
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
