require "spec_helper"

describe "/workspaces", type: :api do
  before(:each) do
    @project = FactoryGirl.create(:project)

    header 'X-Magpie-ProjectId', @project.id
    header 'Accept', '*/*'
  end

  it "should create workspace" do
    post "/workspaces"
    workspace = { id: Workspace.first.id, areas_of_interest: [] }
    last_response.body.should eql(workspace.to_json)
  end

  context "there is one workspace" do
    before(:each) do
      @project.use
      @workspace = FactoryGirl.create(:workspace)
    end

    it "should show workspace" do
      get "/workspaces/#{@workspace.id}"
      workspace = { id: @workspace.id, areas_of_interest: [] }
      last_response.body.should eql(workspace.to_json)
    end
  end
end
