require "spec_helper"

describe "/projects", type: :api do
  before(:each) do
    @project = FactoryGirl.create(:project)
#    @second_project = FactoryGirl.create(:project, name: 'second_project')
  end

  it "should return project" do
    get "/projects/#{@project.id}.json"
    project = { id: @project.id, name: @project.name, layers: [] }
    last_response.body.should eql(project.to_json)
  end

#  it "should return project" do
#    get "/projects/#{@first_project.id}.json", { 'X-Magpie-ProjectId' => @second_project.id }
#    error = { error: 'X-Magpie-ProjectId header does not match requested project.' }
#    last_response.body.should eql(error.to_json)
#  end
end
