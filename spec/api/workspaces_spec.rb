require "spec_helper"

resource "Workspace" do

  get "/workspaces/:id" do
    parameter :id, "Workspace ID"

    let(:workspace) { create(:workspace) }

    example_request "Getting a specific workspace" do
      explanation "curl localhost:3000/workspaces/2"
      @id = workspace.id 
      do_request(:id => workspace.id)
      status.should == 200
      response_body.should be_json_eql workspace.to_json
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
