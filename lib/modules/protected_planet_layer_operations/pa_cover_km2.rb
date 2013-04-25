module ProtectedPlanetLayerOperations::PaCoverKm2
  Name = 'pa_cover_km2'
  DisplayName = 'Area of AOIs within Protected Area'

  def self.perform(area_of_interest)
    response = ProtectedPlanetLayerOperations::query_protected_planet(area_of_interest)

    return response["sum_pa_cover_km2"].to_f
  end
end
