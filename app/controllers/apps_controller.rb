class AppsController < ApplicationController
  def show
    @app_layers = AppLayer.all
    render
  end
end
