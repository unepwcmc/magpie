class WorkspacesController < ApplicationController
  respond_to :json

  def show
    @workspace = Workspace.find(params[:id])
    respond_with(@workspace)
  end

  def create
    @workspace = Workspace.create(params[:workspace])
    respond_with(@workspace)
  end
end
