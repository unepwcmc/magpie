class ProtectedPlanetLayer < ProjectLayer
  def self.get_providers
    [{"id" => 1, "display_name" => "Protected Areas", "tiles_url_format" => "http://184.73.201.235/blue/{z}/{x}/{y}"}]
  end

  def self.get_operations
    operations = []
    AVAILABLE_OPERATIONS.each do |k,v|
      operations << {"display_name" => v[:name], "name" => k.to_s}
    end

    return operations
  end

  def fetch_result(result)
    aoi = result.area_of_interest

    if aoi.polygons.count > 0
      response = RestClient.post("http://protectedplanet.net/api2/geo_searches", "data=#{aoi.to_wkt.to_json}")
      response_json = JSON.parse(response)

      if response_json['error']
        raise TimeoutError, 'Area was too large to calculate.'
      end
      
      operation_fetch = ProtectedPlanetLayer::AVAILABLE_OPERATIONS[result.calculation.operation.to_sym][:fetch]
      operation_fetch.call(response_json)
    end
  end

  def self.result_class(id)
    AVAILABLE_OPERATIONS[id.to_sym][:result_class]
  end

  private

  AVAILABLE_OPERATIONS = {
    number_protected_areas: {
      name: 'Number of Protected Areas',
      result_class: FloatResult,
      fetch: lambda { |response|
        polygons = response['results']
        polygons.map! do |polygon|
          protected_areas = polygon['protected_areas']
          protected_areas.map { |pa| pa['data_standard']['WDPAID'] }
        end

        return polygons.flatten.uniq.length
      }
    },
    sum_pa_cover_km2: {
      name: 'AOI within Protected Area (km)',
      result_class: FloatResult,
      fetch: lambda { |response| return response["sum_pa_cover_km2"].to_f }
    },
    protected_areas_details: {
      name: 'Protected Areas Details',
      result_class: JsonResult,
      fetch: lambda { |response| return response['results'].to_json }
    }
  }
end