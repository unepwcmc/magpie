class RasterLayer < ProjectLayer
  def rasters_select
    get_rasters.map { |r| [r['display_name'], r['id']] }
  end

  def get_rasters
    JSON.parse(RestClient.get('http://raster-stats.unep-wcmc.org/rasters.json'))
  end

  def operations_select
    JSON.parse(RestClient.get('http://raster-stats.unep-wcmc.org/operations.json')).map { |r| [r['display_name'], r['name']] }
  end
end
