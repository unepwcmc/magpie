module BlueCarbonLayerOperations
  def self.cartodb_query query_name, geoms
    sql = CarbonQuery.send(query_name.to_sym, geoms.join(", "), 'bc_carbon_view')

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
end

