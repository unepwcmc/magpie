module ProtectedPlanetLayerOperations
  QUERY_FILTERS = {
    skip_carbon_stats: true,
    only_data_standard: true
  }.to_json

  def self.query_protected_planet(area_of_interest)
    if area_of_interest.polygons.count > 0
      key = "aoi-#{area_of_interest.id}-#{area_of_interest.most_recent_polygon_updated_at}"

      response_json = Rails.cache.fetch(key) do
        response = RestClient.post("http://protectedplanet.net/api2/geo_searches", "data=#{area_of_interest.to_wkt.to_json}&filters=#{QUERY_FILTERS}")
        JSON.parse(response)
      end

      if response_json['error']
        raise TimeoutError, 'Area was too large to calculate.'
      else
        response_json
      end
    end
  end
end
