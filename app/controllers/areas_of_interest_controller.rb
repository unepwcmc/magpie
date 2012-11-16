class AreasOfInterestController < ApplicationController
  def create
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.create(params.merge({
      :workspace_id => request.path_parameters[:workspace_id]
    }))
    render 'areas_of_interest/save', :status => 201
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    @aoi.update_attributes(params)
    render 'areas_of_interest/save'
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    render
  end

  def calculated_stats
    aoi = AreaOfInterest.find(request.path_parameters[:id])
    @records = aoi.app_layers
    render
  end
end
