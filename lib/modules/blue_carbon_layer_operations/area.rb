module BlueCarbonLayerOperations::Area
  Name = 'area'
  DisplayName = 'Area'

  def self.perform(area_of_interest)
    geoms = []
    area_of_interest.polygons_as_geo_json_polygons.each do |polygon|
      geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
    end

    response = BlueCarbonLayerOperations.cartodb_query(:polygon_area_km2, geoms)
    return response
  end
end
