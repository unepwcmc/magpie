class ProtectedPlanetLayer < ProjectLayer
  def rasters_select
    get_rasters.map { |r| [r['display_name'], r['id']] }
  end

  def get_rasters
    [{"id" => 1, "display_name" => "Protected Areas", "tiles_url_format" => "http://184.73.201.235/blue/{z}/{x}/{y}"}]
  end

  def operations_select
    operations = []
    AVAILABLE_OPERATIONS.each { |k,v| operations << [v[:name], k] }
    return operations
  end

  def fetch_result(result)
    aoi = result.area_of_interest

    if aoi.polygons.count > 0
      response = RestClient.post("http://protectedplanet.net/api2/geo_searches", "data=#{aoi.to_wkt.to_json}")
      response_json = JSON.parse(response)

      operation = self.class.result_class(result.calculation.operation)
      operation.fetch(response_json)
    end
  end

  def self.result_class(id)
    AVAILABLE_OPERATIONS[id.to_sym].result_class
  end

  private

  AVAILABLE_OPERATIONS = {
    number_protected_areas: {
      name: 'Number of Protected Areas',
      result_class: FloatResult,
      fetch: lambda { |response| return 7 }
    },
    sum_pa_cover_km2: {
      name: 'AOI within Protected Area (km)',
      result_class: FloatResult,
      fetch: lambda { |response| return response["sum_pa_cover_km2"].to_f }
    },
    protected_areas_details: {
      name: 'Protected Areas Details',
      result_class: JsonResult,
      fetch: lambda { |response| return {} }
    }
  }
end
