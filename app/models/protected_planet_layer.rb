class ProtectedPlanetLayer < ProjectLayer
  def self.get_providers
    [{"id" => 1, "display_name" => "Protected Areas", "tiles_url_format" => "http://184.73.201.235/blue/{z}/{x}/{y}"}]
  end

  private

  AVAILABLE_OPERATIONS = {
    number_protected_areas: {
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
      result_class: Result,
      fetch: lambda { |response| return response["sum_pa_cover_km2"].to_f }
    },
    protected_areas_details: {
      name: 'Protected Areas Details',
      result_class: Result,
      fetch: lambda { |response| return response['results'].to_json }
    }
  }
end
