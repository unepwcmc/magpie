class AnalysesController < ApplicationController
  def update
    #TODO Apartment custom elevator causes path params not to appear in params
    @analysis = Analysis.find(request.path_parameters[:id])
    @analysis.update_attributes(params[:analysis])
    render :json => @analysis
  end

  def show
    #TODO Apartment custom elevator causes path params not to appear in params
    @analysis = Analysis.find(request.path_parameters[:id])
    render :json => @analysis
  end
end
