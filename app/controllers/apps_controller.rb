class AppsController < ApplicationController

  skip_before_filter :ensure_app, :only => [:new, :create]

  def show
    @app_layers = AppLayer.all
    render
  end

  def new
    @app = App.new
  end

  def create
    render :json => { error: 'Sorry, this is not available yet' }
  end
end
