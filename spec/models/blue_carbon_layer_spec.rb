require 'spec_helper'

describe BlueCarbonLayer do
  describe "#get_providers" do
    it "should return layer providers" do
      pending
    end
  end

  describe "#get_operations" do
    before :all do
      @result = BlueCarbonLayer.get_operations
    end
    it "should return sum only" do
      @result.should match_array [{
        name: "sum",
        display_name: "Sum"
      }]
    end
  end
end
