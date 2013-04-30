module BlueCarbonLayerOperations::Carbon
  Name = 'carbon'
  DisplayName = 'Carbon'

  def self.perform(area_of_interest)
    geoms = []
    area_of_interest.polygons_as_geo_json_polygons.each do |polygon|
      geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
    end

    response = BlueCarbonLayerOperations.cartodb_query(:habitat, geoms)
    return response.to_json
  end
end