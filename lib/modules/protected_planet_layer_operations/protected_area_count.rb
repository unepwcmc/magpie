module ProtectedPlanetLayerOperations::ProtectedAreaCount
  Name = 'protected_area_count'
  DisplayName = 'Protected Area Count'

  def self.perform(area_of_interest)
    response = ProtectedPlanetLayerOperations::query_protected_planet(area_of_interest)
    polygons = response['results']

    polygons.map! do |polygon|
      protected_areas = polygon['protected_areas']
      protected_areas.map { |pa| pa['data_standard']['WDPAID'] }
    end

    return polygons.flatten.uniq.length
  end
end
