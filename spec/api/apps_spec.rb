require "spec_helper"

resource "Apps" do
  get "/apps/:id" do
    parameter :id, "App ID"
    let!(:app_layer) { create(:app_layer) }

    example_request "Getting an app information" do
      do_request
      status.should == 200
      expected = {
        :app_layers => [{
          :id => app_layer.id,
          :display_name => app_layer.display_name,
          :tile_url => app_layer.tile_url,
          :is_displayed => app_layer.is_displayed
        }]
      }
      response_body.should be_json_eql(expected.to_json)
    end
  end
end

