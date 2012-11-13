class LayersController < ApplicationController
  def index
    render :json => TenantLayer.includes(:layer).map{ |tl| tl.layer }
  end
  def layer_calculations
    render :json => TenantLayer.layer_calculations(params[:layer_id])
  end
end
