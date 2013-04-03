require 'spec_helper'

describe BlueCarbonLayer do
  describe "#get_providers" do
    before :all do
      @result = BlueCarbonLayer.get_providers
    end
    it "returns the blue carbon cartodb layers" do
      @result.should match_array([
        {display_name: 'Mangrove', tiles_url_format: 'https://carbon-tool.cartodb.com/tiles/bc_mangrove/{z}/{x}/{y}.png?sql=SELECT * FROM bc_mangrove WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)'},
        {display_name: 'Seagrass', tiles_url_format: 'https://carbon-tool.cartodb.com/tiles/bc_seagrass/{z}/{x}/{y}.png?sql=SELECT * FROM bc_seagrass WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)'},
        {display_name: 'Sabkha', tiles_url_format: 'https://carbon-tool.cartodb.com/tiles/bc_sabkha/{z}/{x}/{y}.png?sql=SELECT * FROM bc_sabkha WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)'},
        {display_name: 'Salt Marsh', tiles_url_format: 'https://carbon-tool.cartodb.com/tiles/bc_saltmarsh/{z}/{x}/{y}.png?sql=SELECT * FROM bc_saltmarsh WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)'},
        {display_name: 'Algal Mat', tiles_url_format: 'https://carbon-tool.cartodb.com/tiles/bc_algal_mat/{z}/{x}/{y}.png?sql=SELECT * FROM bc_algal_mat WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)'},
        {display_name: 'Other', tiles_url_format: 'https://carbon-tool.cartodb.com/tiles/bc_other/{z}/{x}/{y}.png?sql=SELECT * FROM bc_other WHERE toggle = true AND (action <> \'delete\' OR action IS NULL)'}
      ])
    end
  end

  describe "#get_operations" do
    before :all do
      @result = BlueCarbonLayer.get_operations
    end
    it "returns the sum only" do
      @result.should match_array [{
        name: "sum",
        display_name: "Sum"
      }]
    end
  end
end
