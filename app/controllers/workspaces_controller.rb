class WorkspacesController < ApplicationController

  def create
    @workspace = Workspace.create
    render :json => @workspace
  end

  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @workspace = Workspace.find(request.path_parameters[:id])
    @workspace.update_attributes(params)
    render :json => @workspace
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @workspace = Workspace.find(request.path_parameters[:id])
    render :json => @workspace
  end
end
