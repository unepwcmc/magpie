class AreasOfInterestController < ApplicationController
  respond_to :json, except: :show

  def show
    @area_of_interest = AreaOfInterest.find(params[:id])
    @area_of_interest.generate_results params[:statistics] || []

    respond_to do |format|
      format.json
      format.csv {
        send_data @area_of_interest.to_csv, filename: "#{@area_of_interest.name.parameterize}.csv"
      }
    end 
  end

  def create
    workspace = Workspace.find(params[:workspace_id])
    @area_of_interest = workspace.areas_of_interest.new(params[:area_of_interest])
    flash[:notice] = 'Area of Interest was successfully created.' if @area_of_interest.save
    respond_with(@area_of_interest)
  end

  def update
    @area_of_interest = AreaOfInterest.find(params[:id])
    flash[:notice] = 'Area of Interest was successfully updated.' if @area_of_interest.update_attributes(params[:area_of_interest])
    respond_with(@area_of_interest)
  end

  def destroy
    @area_of_interest = AreaOfInterest.find(params[:id])
    @area_of_interest.destroy
    flash[:notice] = 'Area of Interest was successfully destroyed.'
    respond_with(@area_of_interest)
  end
end
