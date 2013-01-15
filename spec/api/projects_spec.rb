require "spec_helper"

describe "/projects" do
  before(:each) do
    @project = FactoryGirl.create(:project)
  end

  it "JSON" do
    @status, @headers, @response = Rails.application.call(Rack::MockRequest.env_for("/projects/#{@project.id}.json"))

    p @status
    p @headers.inspect
    p @response
    p @response.body
  end
end
