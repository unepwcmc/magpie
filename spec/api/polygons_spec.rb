require "spec_helper"

resource "Polygon" do

  get "/polygons/:id" do
    parameter :id, "Polygon ID"

    let(:polygon) { create(:polygon) }
    let(:id) { polygon.id }

    example_request "Getting a specific polygon" do
      explanation "curl localhost:3000/polygons/2"
      do_request
      status.should == 200
      response_body.should be_json_eql polygon.to_json
    end
  end

  post "/polygons" do
    parameter :geometry, "Polygon geometry geojson"
    let(:geometry) { [50,50].to_json }
    scope_parameters :polygon, :all
    example_request "Creating a new polygon" do
      do_request
      status.should == 200
      response_body.should have_json_path 'analysis'
      response_body.should have_json_path 'area'
      response_body.should be_json_eql(params.to_json).
        excluding("analysis").excluding("area").excluding("area_id")
    end
  end

  put "/polygons/:id" do
    parameter :id, "Polygon id"
    parameter :geometry, "Polygon geometry geojson"
    let(:polygon) { create(:polygon) }
    let(:id) { polygon.id }
    let(:geometry) { [60,60].to_json }
    scope_parameters :polygon, :all
    example_request "Updating an existing polygon" do
      do_request
      status.should == 200
      response_body.should be_json_eql(params["polygon"].to_json).
        excluding("area_id")
    end
  end

end
