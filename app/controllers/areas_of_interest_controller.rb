class AreasOfInterestController < ApplicationController
  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    @aoi.update_attributes(params)
    render :json => @aoi
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    render :json => @aoi
  end

  def calculated_stats
    aoi = AreaOfInterest.find(request.path_parameters[:id])
    @records = aoi.app_layers
    render
  end
end
