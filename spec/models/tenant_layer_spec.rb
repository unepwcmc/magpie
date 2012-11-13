require 'spec_helper'

describe TenantLayer do
  context "available calculations for a particular layer" do
    before(:each) do
      Apartment::Database.switch()
      layer = create(:layer)
      operation1 = create(:operation)
      operation2 = create(:operation)
      calculation = create(
        :calculation,
        :layer_id => layer.id,
        :operation_id => operation1.id
      )
      calculation = create(
        :calculation,
        :layer_id => layer.id,
        :operation_id => operation2.id
      )
      Apartment::Database.switch('carbon')
      create(:tenant_layer, :layer_id => layer.id)
    end
    it "should return 1 element array" do
      TenantLayer.layer_calculations.count.should == 1
    end
  end
  context "available calculations for available layers" do
    before(:each) do
      Apartment::Database.switch()
      layer1 = create(:layer)
      layer2 = create(:layer)
      operation1 = create(:operation)
      operation2 = create(:operation)
      calculation = create(
        :calculation,
        :layer_id => layer1.id,
        :operation_id => operation1.id
      )
      calculation = create(
        :calculation,
        :layer_id => layer2.id,
        :operation_id => operation2.id
      )
      Apartment::Database.switch('carbon')
      create(:tenant_layer, :layer_id => layer1.id)
      create(:tenant_layer, :layer_id => layer2.id)
    end
    it "should return 2 elements" do
      TenantLayer.layer_calculations.count.should == 2
    end
  end
end
