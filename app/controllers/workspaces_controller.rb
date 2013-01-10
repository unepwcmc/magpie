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

  def from_file
    uploaded_io = params[:file]
    content = uploaded_io.read

    render json: "{\"filename\":\"#{uploaded_io.original_filename}\", content: \"#{content}\"}"
  end
end
