module Utils
  TEMPLATES_BASE_PATH = Rails.root.join(
    'lib', 'modules', 'blue_carbon_layer_operations', 'templates'
  )

  def self.render_query query_name, with_binding
    template = File.read(TEMPLATES_BASE_PATH.join("#{query_name}.sql.erb"))
    ERB.new(template).result(with_binding).squish
  end

  def self.query_cartodb query
    response = RestClient.post("#{CARTODB_CONFIG["host"]}/api/v2/sql", {
      q: query,
      api_key: CARTODB_CONFIG["api_key"]
    })

    response = JSON.parse(response)

    if response["total_rows"] > 0
      response["rows"]
    else
      []
    end
  end

  def self.st_makevalid(geometry)
    "ST_MakeValid(#{geometry})"
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
