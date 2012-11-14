require "spec_helper"

resource "Layer" do

  public_scope do
    let(:carbon_layer){ create(:layer, :name => 'carbon') }
    let(:forest_layer){ create(:layer, :name => 'forest') }
    let(:average){ create(:operation, :name => 'average') }
    let(:sum){ create(:operation, :name => 'sum') }
    let!(:carbon_average){ create(
        :calculation,
        :layer_id => carbon_layer.id,
        :operation_id => average.id
      )
    }
    let!(:carbon_sum){ create(
        :calculation,
        :layer_id => carbon_layer.id,
        :operation_id => sum.id
      )
    }
    let!(:forest_average){ create(
        :calculation,
        :layer_id => forest_layer.id,
        :operation_id => average.id
      )
    }
  end

  get "/layers" do
    before(:each) do
      create(:tenant_layer, :layer_id => carbon_layer.id)
      forest_layer
    end
    example_request "Getting the list of layers" do
      explanation "curl localhost:3000/layers"
      do_request
      status.should == 200
      response_body.should have_json_path("layers")
      response_body.should have_json_size(1).at_path("layers")
      response_body.should include_json(carbon_layer.to_json).at_path("layers")
    end
  end

  get "/layer_calculations" do
    before(:each) do
      create(:tenant_layer, :layer_id => carbon_layer.id)
      create(:tenant_layer, :layer_id => forest_layer.id)
    end
    example_request "Getting the list of available layer calculations" do
      explanation "curl localhost:3000/layer_calculations"
      do_request
      status.should == 200
      have_json_size(2).at_path("layer_calculations")
      #response_body.should have_json_path 'layer_calculations'
      #response_body.should be_json_eql [{:layer_id => [calculation1, calculation2]}].to_json
    end
  end

end
