class WorkspacesController < ApplicationController

  def create
    @workspace = Workspace.create
    render
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @workspace = Workspace.find(request.path_parameters[:id])
    render :json => @workspace
  end
end
