class PolygonsController < ApplicationController

  def create
    @analysis = Analysis.create!(:name => 'My Analysis')
    @polygon = Polygon.create(
      params[:polygon].merge({:analysis_id => @analysis.id})
    )
    render :json => {:polygon => @polygon, :analysis => @analysis}
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    @polygon.update_attributes(params[:polygon])
    render :json => @polygon
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find(request.path_parameters[:id])
    render :json => @polygon
  end

end
