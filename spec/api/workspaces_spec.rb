require "spec_helper"

resource "Workspace" do

  get "/workspaces/:id" do
    parameter :id, "Workspace ID"

    let(:workspace) { create(:workspace) }
    let(:area_of_interest) { create(:area_of_interest, :workspace_id => workspace.id, :name => "AOI#1") }
    let!(:polygon) { create(:polygon, :area_of_interest_id => area_of_interest.id) }
    let!(:result) { create(:result, :area_of_interest_id => area_of_interest.id, :value => 20, :name => "AOI#2") }
    let!(:area_of_interest2) { create(:area_of_interest, :workspace_id => workspace.id) }
    let!(:polygon2) { create(:polygon, :area_of_interest_id => area_of_interest2.id) }
    let!(:result2) { create(:result, :area_of_interest_id => area_of_interest2.id, :value => 30) }

    example_request "Getting a specific workspace" do
      explanation "curl localhost:3000/workspaces/2"
      @id = workspace.id 
      do_request(:id => workspace.id)
      status.should == 200
      expected = {
        :id => workspace.id,
        :areas_of_interest => [{
          :id => area_of_interest.id,
          :name => area_of_interest.name,
          :polygons => [{
            :id => polygon.id,
            :geometry => polygon.geometry
          }],
          :results => [{
            :value => result.value,
            :unit => result.calculation.unit,
            :display_name => result.calculation.display_name,
            :app_layer_id => result.calculation.app_layer_id
          }]
        },{
          :id => area_of_interest2.id,
          :name => area_of_interest2.name,
          :polygons => [{
            :id => polygon2.id,
            :geometry => polygon2.geometry
          }],
          :results => [{
            :value => result2.value,
            :unit => result2.calculation.unit,
            :display_name => result2.calculation.display_name,
            :app_layer_id => result2.calculation.app_layer_id
          }]
        }]
      }
      response_body.should be_json_eql expected.to_json
    end
    example_request "Getting an workspace which does not exist" do
      do_request(:id => -1)
      status.should == 200
      response_body.should be_json_eql({:error => 'Resource not found'}.to_json)
    end
  end

  post "/workspaces" do
    example_request "Creating a new workspace" do
      do_request
      status.should == 200
      response_body.should be_json_eql({:id => create(:workspace).id}.to_json)
    end
  end

end
