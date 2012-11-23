require "spec_helper"

resource "AreaOfInterest" do

  get "/areas_of_interest/:id" do
    parameter :id, "Area ID"

    let(:workspace){ create(:workspace) }
    let(:area_of_interest) { create(:area_of_interest, :workspace_id => workspace.id) }
    let!(:polygon) { create(:polygon, :area_of_interest_id => area_of_interest.id) }
    let!(:result) { create(:result, :area_of_interest_id => area_of_interest.id, :value => 20) }

    example_request "Getting a specific area" do
      Result.any_instance.stub(:get).and_return(true)
      explanation "curl localhost:3000/areas_of_interest/2"
      do_request(:id => area_of_interest.id)
      status.should == 200
      expected = {
        :id => area_of_interest.id,
        :name => area_of_interest.name,
        :polygons => [{
          :id => polygon.id,
          :geometry => JSON.parse(polygon.geometry)
        }],
        :results => [{
          :value => result.value,
          :unit => result.calculation.unit,
          :display_name => result.calculation.display_name,
          :app_layer_id => result.calculation.app_layer_id
        }]
      }
      response_body.should be_json_eql expected.to_json
    end
    example_request "Getting an area of interest which does not exist" do
      do_request(:id => -1)
      status.should == 200
      response_body.should be_json_eql({:error => 'Resource not found'}.to_json)
    end
  end

  post "/workspaces/:workspace_id/areas_of_interest" do
    parameter :workspace_id, "Workspace ID"
    parameter :name, "Area of interest name"
    let(:workspace_id) { create(:workspace).id }
    let(:name) { "An interesting area" }
    example_request "Creating a new area of interest" do
      do_request
      status.should == 201
      response_body.should be_json_eql(params.to_json).excluding('workspace_id')
    end
  end

  put "/areas_of_interest/:id" do
    parameter :id, "Area of interest ID"
    parameter :name, "Area of interest name"
    parameter :workspace_id, "Workspace ID"
    let(:workspace_id) { create(:workspace).id }
    let(:area_of_interest) { create(
      :area_of_interest,
      :workspace_id => workspace_id,
      :name => "An interesting area"
    ) }
    let(:id) { area_of_interest.id }
    let(:name) { 'Even more interesting area' }
    example_request "Updating an existing area" do
      do_request
      status.should == 200
      response_body.should be_json_eql(area_of_interest.attributes.merge(params).to_json).
        excluding('is_summary').excluding('workspace_id')
    end
  end

  delete "/areas_of_interest/:id" do
    parameter :id, 'AreaOfInterest ID'
    let(:area_of_interest) { create(:area_of_interest) }
    let(:id) {area_of_interest.id}
    example_request "Deleting an existing area of interest" do
      explanation "curl -i http://localhost:3000/areas_of_interest/2 -X DELETE"
      do_request(:id => id)
      status.should == 200
    end
    example_request "Deleting a non existing area of interest" do
      explanation "curl -i http://localhost:3000/areas_of_interest/-1 -X DELETE"
      do_request(:id => -1)
      status.should == 200
      response_body.should be_json_eql({:error => 'Resource not found'}.to_json)
    end
  end
end
