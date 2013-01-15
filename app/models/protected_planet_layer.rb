class ProtectedPlanetLayer < ProjectLayer
  def rasters_select
    get_rasters.map { |r| [r['display_name'], r['id']] }
  end

  def get_rasters
    [{"id" => 1, "display_name" => "Protected Areas", "tiles_url_format" => "http://184.73.201.235/blue/{z}/{x}/{y}"}]
  end

  def operations_select
    [['Protected area KM2', 'area_protected_km2']]
  end

  def fetch_result(result)
    if result.area_of_interest.polygons.count > 0
      aoi = result.area_of_interest

      response = RestClient.post("http://protectedplanet.net/api2/geo_searches", "data=[{\"id\":\"1\", \"the_geom\":\"#{aoi.to_wkt}\"}]")
      response_json = JSON.parse(response)
      return response_json["sum_pa_cover_km2"].to_f
    end
  end
end
