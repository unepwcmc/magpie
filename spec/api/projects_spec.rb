require "spec_helper"

describe "/projects", type: :api do
  before(:each) do
    @project = FactoryGirl.create(:project)
  end

  it "should return project" do
    get "/projects/#{@project.id}.json"
    project = { id: @project.id, name: @project.name, layers: [] }
    last_response.body.should eql(project.to_json)
  end

  it "should return workspace" do
    #header 'Access-Control-Request-Method', 'POST'
    #header 'Access-Control-Request-Headers', 'X-Magpie-ProjectId'
    #header 'Origin', 'http://localhost:8000'
    #options "/workspaces"
    #p last_response.headers
    #p last_response.body
    header 'X-Magpie-ProjectId', 1
    header 'Accept', '*/*'
    post "/workspaces"
    #p last_response.headers
    #p last_response.body
    workspace = {id: Workspace.first.id, areas_of_interest:[]}
    last_response.body.should eql(workspace.to_json)
  end
end
