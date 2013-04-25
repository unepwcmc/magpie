module BlueCarbonLayerOperations::TotalArea
  Name = 'total_area'
  DisplayName = 'Total Area'

  def self.perform(area_of_interest)
    geoms = []
    area_of_interest.polygons_as_geo_json_polygons.each do |polygon|
      geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
    end

    response = BlueCarbonLayerOperations.cartodb_query(:total_area, geoms)

    if response.length > 0
      return response[0]["area"]
    end

    return 0
  end
end
