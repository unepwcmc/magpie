class AppsController < ApplicationController

  skip_before_filter :ensure_app, :only => [:new, :create]

  def show
    @app_layers = AppLayer.all
    render
  end

  def new
    @app = App.new
    @rasters = JSON.parse(RestClient.get('http://raster-stats.unep-wcmc.org/rasters.json'))
    @operations = JSON.parse(RestClient.get('http://raster-stats.unep-wcmc.org/operations.json'))
  end

  def create
    @app = App.new(params[:app])
    if @app.save && @app.use
      params[:rasters].each do |l|
        id, name = l.split(',')
        AppLayer.create(:type => "RasterLayer", :provider_id => id, :display_name => name, :tile_url => "derp")
      end
      request.headers['HTTP_X_MAGPIE_APPID'] = @app.id
      render :create
    end
  end
end
