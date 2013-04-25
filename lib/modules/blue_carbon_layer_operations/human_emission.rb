module BlueCarbonLayerOperations::HumanEmission
  Name = 'human_emission'
  DisplayName = 'Average Person CO2 Emissions Equivalent'

  def self.perform(area_of_interest)
    geoms = []
    area_of_interest.polygons_as_geo_json_polygons.each do |polygon|
      geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
    end

    response = BlueCarbonLayerOperations.cartodb_query(:total_carbon, geoms)

    if response.length > 0
      carbon = response[0]["carbon"]

      years = 0
      unless carbon.nil?
        co2      = (carbon/1000)*3.67
        years    = co2/22.6
      end

      return years
    end

    return 0
  end
end
