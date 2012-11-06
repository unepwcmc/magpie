class PolygonsController < ApplicationController

  def create
    @analysis = Analysis.find_by_id(params[:analysis_id])
    unless @analysis
      @analysis = Analysis.create!(:name => 'My Analysis')
    end
    @polygon = Polygon.create(
      params[:polygon].merge({:analysis_id => @analysis.id})
    )
    render :json => {:polygon => @polygon, :analysis => @analysis}
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find_by_id(request.path_parameters[:id])
    if @polygon
      @polygon.update_attributes(params[:polygon])
    end
    render :json => @polygon
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @polygon = Polygon.find_by_id(request.path_parameters[:id])
    render :json => @polygon
  end

end
