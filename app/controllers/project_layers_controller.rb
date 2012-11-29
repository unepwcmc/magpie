class ProjectLayersController < ApplicationController
  before_filter :authenticate_admin!
  before_filter :find_project

  respond_to :html, :json
  skip_before_filter :ensure_project

  # GET /project_layers
  # GET /project_layers.json
  def index
    @project_layers = ProjectLayer.all
    respond_with(@project_layers)
  end

  # GET /project_layers/1
  # GET /project_layers/1.json
  def show
    @project_layer = ProjectLayer.find(params[:id])
    respond_with(@project_layer)
  end

  # GET /project_layers/new
  # GET /project_layers/new.json
  def new
    @project_layer = ProjectLayer.new
    respond_with(@project_layer)
  end

  # GET /project_layers/1/edit
  def edit
    @project_layer = ProjectLayer.find(params[:id])
    respond_with(@project_layer)
  end

  # POST /project_layers
  # POST /project_layers.json
  def create
    @project_layer = ProjectLayer.new(params[:project_layer])
    flash[:notice] = 'Project layer was successfully created.' if @project_layer.save
    respond_with(@project, @project_layer)
  end

  # PUT /project_layers/1
  # PUT /project_layers/1.json
  def update
    @project_layer = ProjectLayer.find(params[:id])
    flash[:notice] = 'Project layer was successfully updated.' if @project_layer.update_attributes(params[:project])
    respond_with(@project, @project_layer, :location => project_project_layer_url(@project, @project_layer))
  end

  # DELETE /project_layers/1
  # DELETE /project_layers/1.json
  def destroy
    @project_layer = ProjectLayer.find(params[:id])
    @project_layer.destroy
    flash[:notice] = 'Project layer was successfully destroyed.'
    respond_with(@project, @project_layer)
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
    @project.use
  end
end
