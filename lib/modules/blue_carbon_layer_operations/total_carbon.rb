module BlueCarbonLayerOperations::TotalCarbon
  Name = 'total_carbon'
  DisplayName = 'Total Carbon'

  def self.perform area_of_interest
    geoms = area_of_interest.polygons_as_geo_json_polygons.map do |polygon|
      "ST_GeomFromGeoJSON('#{polygon.to_json}')"
    end

    the_geom = ::Utils.st_makevalid(::Utils.st_union(geoms))
    carbon_view_name = "blueforest_carbon_#{Rails.env}_#{area_of_interest.properties['country']}"

    query = ::Utils.render_query(:total_carbon, binding)
    response = ::Utils.query_cartodb(query)

    response.length > 0 ? response[0]["carbon"] : 0
  end
end
