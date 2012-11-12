class LayersController < ApplicationController
  def index
    render :json => TenantLayer.includes(:layer).map{ |tl| tl.layer }
  end
end
