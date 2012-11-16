class AreasOfInterestController < ApplicationController
  def create
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.create({
      :workspace_id => request.path_parameters[:workspace_id],
      :name => params[:name]
    })
    render 'areas_of_interest/save', :status => 201
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    @aoi.update_attributes({
      :workspace_id => params[:workspace_id],
      :name => params[:name]
    })
    render 'areas_of_interest/save'
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    render
  end

  def destroy
    @aoi = AreaOfInterest.find(request.path_parameters[:id])
    if @aoi.destroy
      head :ok
    else
      head :unauthorized
    end
  end
end
