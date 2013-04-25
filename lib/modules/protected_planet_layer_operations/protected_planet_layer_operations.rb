module ProtectedPlanetLayerOperations
  def self.query_protected_planet(area_of_interest)
    if area_of_interest.polygons.count > 0
      response = RestClient.post("http://protectedplanet.net/api2/geo_searches", "data=#{area_of_interest.to_wkt.to_json}")
      response_json = JSON.parse(response)
      debugger

      if response_json['error']
        raise TimeoutError, 'Area was too large to calculate.'
      end

      return response_json
    end
  end
end
