module ProtectedPlanetLayerOperations::ProtectedAreasDetail
  Name = 'protected_areas_details'
  DisplayName = 'Protected Areas Details'

  def self.perform(area_of_interest)
    response = ProtectedPlanetLayerOperations::query_protected_planet(area_of_interest)

    return response['results'].to_json
  end
end
