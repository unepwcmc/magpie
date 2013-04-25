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
end

describe "/areas_of_interest/:id", type: :api do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @project.use
    @workspace = FactoryGirl.create(:workspace)

    header 'X-Magpie-ProjectId', @project.id
    header 'Accept', '*/*'
  end

  context "there is one area of interest with no results" do
    before(:each) do
      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')
    end

    it "should show area of interest" do
      get "/areas_of_interest/#{@area_of_interest.id}"
      expected_attributes = {
        id: @area_of_interest.id,
        name: 'My Area',
        polygons: [],
        results: []
      }
      last_response.body.should eql(expected_attributes.to_json)
    end
  end

  context "an area of interest exists with result with errors" do
    before(:each) do
      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')
      FactoryGirl.create(:result, area_of_interest: @area_of_interest)
    end

    it 'should not render error attributes' do
      get "/areas_of_interest/#{@area_of_interest.id}"
      json_response = JSON.parse(last_response.body)
      first_result = json_response['results'][0]
      first_result.should_not have_key ('error_message')
    end
  end

  context "an area of interest exists with result errors" do
    before(:each) do
      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')
      FactoryGirl.create(:result, 
                         error_message: "An Error Message", 
                         error_stack: "An Error Stack",
                         area_of_interest: @area_of_interest
                        )
    end

    it 'should show the error fields' do
      get "/areas_of_interest/#{@area_of_interest.id}"
      json_response = JSON.parse(last_response.body)
      first_result = json_response['results'][0]
      first_result['error_message'].should eql('An Error Message')
    end
  end
end
