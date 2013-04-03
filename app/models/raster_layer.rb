class RasterLayer < ProjectLayer
  def get_rasters
    JSON.parse(RestClient.get('http://raster-stats.unep-wcmc.org/rasters.json'))
  end

  def operations_select
    JSON.parse(RestClient.get('http://raster-stats.unep-wcmc.org/operations.json')).map { |r| [r['display_name'], r['name']] }
  end

  def fetch_result(result)
    if result.area_of_interest.polygons.count > 0
      calc, aoi = result.calculation, result.area_of_interest

      response = RestClient.get("http://raster-stats.unep-wcmc.org/rasters/#{calc.project_layer.provider_id}/operations/#{calc.operation}", params: {polygon: aoi.polygons_as_geo_json})
      response_json = JSON.parse(response)
      return response_json["value"].to_f
    end
  end

  def self.result_class(id)
    FloatResult
  end
end
