class BlueCarbonLayer < ProjectLayer

  PROVIDER_LAYERS = {
    1 => {
      name: 'Mangrove',
      table_name: 'mangrove'
    },
    2 => {
      table_name: 'seagrass',
      name: 'Seagrass'
    },
    3 => {
      table_name: 'sabkha',
      name: 'Sabkha'
    },
    4 => {
      table_name: 'saltmarsh',
      name: 'Salt Marsh'
    },
    5 => {
      table_name: 'algal_mat',
      name: 'Algal Mat'
    },
    6 => {
      table_name: 'other',
      name: 'Other'
    }
  }

  AVAILABLE_OPERATIONS = {
    carbon: {
      name: 'Carbon',
      result_class: JsonResult,
      fetch: lambda { |result|
        aoi = result.area_of_interest
        st_geoms = []
        aoi.polygons_as_geo_json_polygons.each do |polygon|
          st_geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
        end
        st_geoms = st_geoms.join(", ")
        sql = SQL[:carbon].call(st_geoms)
        puts "SQL"
        puts sql
        response = RestClient.post("#{CARTODB_CONFIG["host"]}/api/v2/sql" , {
          q: sql,
          api_key: CARTODB_CONFIG["api_key"]
        })

        return response
      }
    },

    area: {
      name: 'Area',
      result_class: JsonResult,
      fetch: lambda { |result|
        aoi = result.area_of_interest
        st_geoms = []
        aoi.polygons_as_geo_json_polygons.each do |polygon|
          st_geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
        end
        st_geoms = st_geoms.join(", ")
        sql = SQL[:area].call(st_geoms)
        puts "SQL"
        puts sql
        response = RestClient.post("#{CARTODB_CONFIG["host"]}/api/v2/sql" , {
          q: sql,
          api_key: CARTODB_CONFIG["api_key"]
        })

        return response
      }
    },

    human_emissions: {
      name: 'Human Emissions',
      result_class: FloatResult,
      fetch: lambda { |result|
        aoi = result.area_of_interest
        st_geoms = []
        aoi.polygons_as_geo_json_polygons.each do |polygon|
          st_geoms << "ST_GeomFromGeoJSON('#{polygon.to_json}')"
        end
        st_geoms = st_geoms.join(", ")
        sql = SQL[:human_emissions].call(st_geoms)
        puts "SQL"
        puts sql
        response = RestClient.post("#{CARTODB_CONFIG["host"]}/api/v2/sql" , {
          q: sql,
          api_key: CARTODB_CONFIG["api_key"]
        })

        response = JSON.parse(response)
        carbon   = response["rows"][0]["carbon"]

        years = 0
        unless carbon.nil?
          co2      = (carbon/1000)*3.67
          years    = co2/22.6
        end

        return years
      }
    }
  }

  SQL = {
    carbon: lambda { |geom|
        """
        SELECT habitat, SUM(carbon) as carbon FROM
        (SELECT ST_AREA(ST_Transform(ST_SetSRID(ST_INTERSECTION(b.the_geom, a.the_geom), 4326),27040))/10000*c_mg_ha as carbon, habitat 
        FROM bc_carbon_view a
        INNER JOIN 
          (SELECT 
            ST_SetSRID(
              ST_Union(
                #{geom}
              )
            , 4326)
           as the_geom
          ) b
        ON ST_Intersects(a.the_geom, b.the_geom)) c
        GROUP BY habitat;
        """ },
    area: lambda { |geom|
        """
        SELECT habitat, SUM(area) as area FROM
        (SELECT ST_AREA(ST_Transform(ST_SetSRID(ST_INTERSECTION(b.the_geom, a.the_geom), 4326),27040))/1000 as area, habitat 
        FROM bc_carbon_view a
        INNER JOIN 
          (SELECT 
            ST_SetSRID(
              ST_Union(
                #{geom}
              )
            , 4326)
           as the_geom
          ) b
        ON ST_Intersects(a.the_geom, b.the_geom)) c
        GROUP BY habitat;
        """ },
    human_emissions: lambda { |geom|
        """
        SELECT SUM(carbon) as carbon FROM
        (SELECT ST_AREA(ST_Transform(ST_SetSRID(ST_INTERSECTION(b.the_geom, a.the_geom), 4326),27040))/10000*c_mg_ha as carbon
        FROM bc_carbon_view a
        INNER JOIN 
          (SELECT 
            ST_SetSRID(
              ST_Union(
                #{geom}
              )
            , 4326)
           as the_geom
          ) b
        ON ST_Intersects(a.the_geom, b.the_geom)) c;
        """ }
  }

  def self.get_providers
    providers = []
    PROVIDER_LAYERS.each do |id, attributes|
      providers.push({
        'id' => id,
        'display_name' => attributes[:name], 
        'tiles_url_format' => "https://carbon-tool.cartodb.com/tiles/bc_#{attributes[:table_name]}/{z}/{x}/{y}.png?sql=SELECT * FROM bc_#{attributes[:table_name]} WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)"
      })
    end
    return providers
  end

  def self.get_operations
    operations = []
    AVAILABLE_OPERATIONS.each do |name, attributes|
      operations.push({
        'name' => name,
        'display_name' => attributes[:name]
      })
    end
    return operations
  end

  def fetch_result(result)
    aoi = result.area_of_interest
    if aoi.polygons.count > 0
      operation_fetch = BlueCarbonLayer::AVAILABLE_OPERATIONS[result.calculation.operation.to_sym][:fetch]
      operation_fetch.call(result)
    end
  end

  def table_name
    #"bc_#{PROVIDER_LAYERS[self.provider_id][:table_name]}"
    "bc_carbon_view"
  end

  def self.result_class(id)
    AVAILABLE_OPERATIONS[id.to_sym][:result_class]
  end
end
