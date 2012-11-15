class LayersController < ApplicationController
  def index
    @layers = AppLayer.joins(:layer).includes(:layer).map(&:layer)
    render "layers/index"
  end
  def layer_calculations
    @layers_with_calculations = AppLayer.layers_with_calculations(params[:layer_id])
    render "layers/calculations"
  end
end
