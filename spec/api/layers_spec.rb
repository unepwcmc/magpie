require "spec_helper"

resource "Layer" do

  get "/layers" do
    before(:each) do
      Apartment::Database.switch()
      @layer = create(:layer)
      Apartment::Database.switch('carbon')
      create(:tenant_layer, :layer_id => @layer)
    end
    example_request "Getting the list of layers" do
      explanation "curl localhost:3000/layers"
      do_request
      status.should == 200
      response_body.should be_json_eql [@layer].to_json
    end
  end

  get "/layer_calculations" do
    before(:each) do
      Apartment::Database.switch()
      layer = create(:layer)
      operation1 = create(:operation)
      operation2 = create(:operation)
      @calculation1 = create(
        :calculation,
        :layer_id => layer.id,
        :operation_id => operation1.id
      )
      @calculation2 = create(
        :calculation,
        :layer_id => layer.id,
        :operation_id => operation2.id
      )
      Apartment::Database.switch('carbon')
      create(:tenant_layer, :layer_id => layer.id)
    end
    pending "Getting the list of available layer calculations"
      # explanation "curl localhost:3000/layer_calculations"
      # do_request
      # status.should == 200
      # response_body.should be_json_eql [{:layer_id => [@calculation1, @calculation2]}].to_json
    # end
    pending "Getting the list of available calculations for a particular layer"
  end
end
