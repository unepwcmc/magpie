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
    parameter :area_id, "Area ID"
    let(:geometry) { [50,50].to_json }
    let(:area_of_interest) { create(:area_of_interest, :workspace_id => create(:workspace).id) }
    let(:area_of_interest_id) { area_of_interest.id }
    example_request "Creating a new polygon" do
      do_request
      status.should == 200
      response_body.should be_json_eql(params.to_json)
    end
  end

  put "/polygons/:id" do
    parameter :id, "Polygon id"
    parameter :geometry, "Polygon geometry geojson"
    let(:polygon) { create(:polygon) }
    let(:id) { polygon.id }
    let(:geometry) { [60,60].to_json }
    example_request "Updating an existing polygon" do
      do_request
      status.should == 200
      response_body.should be_json_eql(params.to_json).
        excluding("area_id")
    end
  end

end
