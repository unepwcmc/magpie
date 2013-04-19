module BlueCarbonLayerOperations
  def self.cartodb_query query_name, geoms
    geometry = st_union(geoms)
    sql = CarbonQuery.send(query_name.to_sym, geometry, 'bc_carbon_view')

    response = RestClient.post("#{CARTODB_CONFIG["host"]}/api/v2/sql" , {
      q: sql,
      api_key: CARTODB_CONFIG["api_key"]
    })

    response = JSON.parse(response)

    if response["total_rows"] > 0
      return response["rows"]
    else
      return []
    end
  end

  def self.st_union(geoms)
    return geoms.first if geoms.length == 1

    geoms_as_st_union = ""
    geoms.each_with_index do |geom, i|
      next_geom = geoms[i+1]

      unless next_geom.nil?
        unless geoms_as_st_union.empty?
          geoms_as_st_union = "ST_Union(#{geoms_as_st_union}, #{next_geom})"
        else
          geoms_as_st_union = "ST_Union(#{geom}, #{next_geom})"
        end
      end
    end

    return geoms_as_st_union
  end
end
