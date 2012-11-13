class AreasController < ApplicationController
  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @area = Area.find(request.path_parameters[:id])
    @area.update_attributes(params[:area])
    render :json => @area
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @area = Area.find(request.path_parameters[:id])
    render :json => @area
  end
end
