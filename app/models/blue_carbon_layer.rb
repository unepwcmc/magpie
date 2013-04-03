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
    sum: {
      name: 'Sum',
      result_class: FloatResult
    }
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
      sql = "
        SELECT habitat, SUM(carbon) as carbon FROM
        (SELECT ST_AREA(ST_Transform(ST_SetSRID(ST_INTERSECTION(b.the_geom, a.the_geom), 4326),27040))/10000*c_mg_ha as carbon, habitat 
        FROM #{self.table_name} a 
        INNER JOIN 
          (SELECT 
            ST_SetSRID(
              ST_GeomFromGeoJSON('#{aoi.polygons_as_geo_json_multipolygon}')
            , 4326)
           as the_geom
          ) b 
        ON ST_Intersects(a.the_geom, b.the_geom)) c
        GROUP BY habitat;
      "
      puts sql
      response = RestClient.post "https://carbon-tool.cartodb.com/api/v2/sql" , params: {
        q: sql
      }
      response_json = JSON.parse(response)
      return response_json
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
