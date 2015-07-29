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
end
