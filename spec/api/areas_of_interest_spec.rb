require "spec_helper"

resource "AreaOfInterest" do

  get "/areas_of_interest/:id" do
    parameter :id, "Area ID"

    let(:workspace){ create(:workspace) }
    let(:area_of_interest) { create(:area_of_interest, :workspace_id => workspace.id) }

    example_request "Getting a specific area" do
      explanation "curl localhost:3000/areas_of_interest/2"
      @id = area_of_interest.id 
      do_request(:id => area_of_interest.id)
      status.should == 200
      response_body.should be_json_eql area_of_interest.to_json
    end
    example_request "Getting an area of interest which does not exist" do
      do_request(:id => -1)
      status.should == 200
      response_body.should be_json_eql({:error => 'Resource not found'}.to_json)
    end
  end

  put "/areas_of_interest/:id" do
    parameter :id, "Area of interest ID"
    parameter :name, "Area of interest name"
    let(:workspace) { create(:workspace) }
    let(:area_of_interest) { create(:area_of_interest, :workspace_id => workspace.id) }
    let(:id) { area_of_interest.id }
    let(:name) { 'Even more interesting area' }
    scope_parameters :area, :all
    example_request "Updating an existing area" do
      do_request
      status.should == 200
      response_body.should be_json_eql(params["area"].to_json).
        excluding('workspace_id').excluding('is_summary')
    end
  end

end