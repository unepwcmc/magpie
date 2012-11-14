require 'spec_helper'

describe TenantLayer do

  context "available calculations for layers" do

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

    before(:each) do
      @tenant_layer = create(:tenant_layer, :layer_id => carbon_layer.id)
      create(:tenant_layer, :layer_id => forest_layer.id)
    end
    it "should return 1 element if layer is specified" do
      TenantLayer.layers_with_calculations(@tenant_layer.layer_id).count.should == 1
    end

    it "should return 2 elements if layer is unspecified" do
      TenantLayer.layers_with_calculations.count.should == 2
    end
  end
end
