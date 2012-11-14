class PolygonsController < ApplicationController

  def create
    if params[:area_id].blank?
      @analysis = Analysis.create!(:name => 'My Analysis')
      @area = Area.create(:name => 'AOI#1', :analysis_id => @analysis.id)
    else
      @area = Area.find(params[:area_id])
    end
    @polygon = Polygon.create(
      params.merge({:area_id => @area.id})
    )
    render :json => {:polygon => @polygon, :analysis => @analysis, :area => @area}
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
