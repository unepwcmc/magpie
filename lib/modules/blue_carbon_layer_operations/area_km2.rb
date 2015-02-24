module BlueCarbonLayerOperations::AreaKm2
  Name = 'area_km2'
  DisplayName = 'Area'

  def self.perform(area_of_interest)
    geoms = []
    area_of_interest.polygons_as_geo_json_polygons.each do |polygon|
      geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
    end

    the_geom = ::Utils.st_makevalid(::Utils.st_union(geoms))
    country_name = area_of_interest.properties['country']

    query = ::Utils.render_query(:area_km2, binding)
    response = ::Utils.query_cartodb(query)

    return response.to_json
  end
end
