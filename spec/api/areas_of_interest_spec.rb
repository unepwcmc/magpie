require "spec_helper"

describe "/areas_of_interest", type: :api do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @project.use
    @workspace = FactoryGirl.create(:workspace)

    header 'X-Magpie-ProjectId', @project.id
    header 'Accept', '*/*'
  end

  it "should create area of interest" do
    post "/workspaces/#{@workspace.id}/areas_of_interest", {area_of_interest: {name: 'Area of Interest'}}
    area_of_interest = { id: AreaOfInterest.first.id, name: 'Area of Interest' }
    last_response.body.should eql(area_of_interest.to_json)
  end

  context "there is one area of interest" do
    before(:each) do
      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')
    end

    it "should show area of interest" do
      get "/areas_of_interest/#{@area_of_interest.id}"
      area_of_interest = { id: @area_of_interest.id, name: 'My Area', polygons: [], results: [] }
      last_response.body.should eql(area_of_interest.to_json)
    end
  end
end
