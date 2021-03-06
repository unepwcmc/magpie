class ProjectsController < ApplicationController
  before_filter :authenticate_admin!, unless: :is_it_show_json?

  respond_to :html, :json
  skip_before_filter :ensure_project

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    respond_with(@projects)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])

    # Switch content
    @project.use
    @layers = ProjectLayer.find(:all)

    respond_with(@project)
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    respond_with(@project)
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    respond_with(@project)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])
    flash[:notice] = 'Project was successfully created.' if @project.save
    respond_with(@project)
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    flash[:notice] = 'Project was successfully updated.' if @project.update_attributes(params[:project])
    respond_with(@project)
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = 'Project was successfully destroyed.'
    respond_with(@project)
  end

  private

  def is_it_show_json?
    request['action'] == 'show' && request.format.json?
  end
end
