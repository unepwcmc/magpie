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
      params[:layers].each do |layer_id, options|
        break if options["include"] != "1"
        layer = AppLayer.create(:type => "RasterLayer", :provider_id => layer_id, :display_name => options["display_name"], :is_displayed => (options.has_key?("display") && options["display"] == "1"),  :tile_url => "derp")
        options["operations"].each do |key, h|
          operation = Operation.find_or_create_by_name(key.downcase)
          if h.has_key?("include") && h["include"] == "1"
            layer.calculations.create(:display_name => h["display_name"], :unit => h["unit"])
          end
        end
      end
      request.headers['HTTP_X_MAGPIE_APPID'] = @app.id
      render :create
    end
  end
end
