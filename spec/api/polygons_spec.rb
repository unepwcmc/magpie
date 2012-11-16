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
      expected = {
        :id => polygon.id,
        :geometry => polygon.geometry,
        :area_of_interest_id => polygon.area_of_interest_id
      }
      response_body.should be_json_eql expected.to_json
    end
  end

  post "/areas_of_interest/:area_of_interest_id/polygons" do
    parameter :area_of_interest_id, "Area of Interest ID"
    parameter :geometry, "Polygon geometry geojson"
    let(:area_of_interest) { create(:area_of_interest) }
    let(:area_of_interest_id) { area_of_interest.id }
    let(:geometry) { [50,50].to_json }
    let(:polygon) { create(:polygon, :geometry => geometry, :area_of_interest_id => area_of_interest.id)}

    example_request "Creating a new polygon" do
      do_request
      status.should == 201
      expected = {
        :id => polygon.id,
        :geometry => geometry,
        :area_of_interest_id => area_of_interest_id
      }
      response_body.should be_json_eql(expected.to_json)
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
      expected = {
        :id => polygon.id,
        :geometry => geometry,
        :area_of_interest_id => polygon.area_of_interest_id
      }
      response_body.should be_json_eql(expected.to_json)
    end
  end
  delete "/polygons/:id" do
    parameter :id, 'Polygon ID'
    let(:polygon) { create(:polygon) }
    let(:id) {workspace.id}
    example_request "Deleting an existing polygon" do
      do_request(:id => id)
      status.should == 200
    end
    example_request "Deleting a non existing polygon" do
      do_request(:id => -1)
      status.should == 200
      response_body.should be_json_eql({:error => 'Resource not found'}.to_json)
    end
  end
end
