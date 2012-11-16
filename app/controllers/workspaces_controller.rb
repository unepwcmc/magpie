class WorkspacesController < ApplicationController

  def create
    @workspace = Workspace.create
    render :status => 201
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @workspace = Workspace.find(request.path_parameters[:id])
    render
  end

  def destroy
    @workspace = Workspace.find(request.path_parameters[:id])
    if @workspace.destroy
      head :ok
    else
      head :unauthorized
    end
  end
end
