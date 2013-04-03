class BlueCarbonLayer < ProjectLayer
  PROVIDER_LAYERS = {
    'mangrove' => 'Mangrove',
    'seagrass' => 'Seagrass',
    'sabkha' => 'Sabkha',
    'saltmarsh' => 'Salt Marsh',
    'algal_mat' => 'Algal Mat',
    'other' => 'Other'
  }

  def self.get_providers
    providers = []
    PROVIDER_LAYERS.each do |name, display_name|
      providers.push({
        display_name: display_name, 
        tiles_url_format: "https://carbon-tool.cartodb.com/tiles/bc_#{name}/{z}/{x}/{y}.png?sql=SELECT * FROM bc_#{name} WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)"
      })
    end
    return providers
  end

  def self.get_operations
    return [{
        name: "sum",
        display_name: "Sum"
      }]
  end
end
