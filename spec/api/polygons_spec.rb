require "spec_helper"

describe "/polygons", type: :api do
  let(:geometry) {
    { type: "Polygon", coordinates: [[[52.723388671875, 24.78174733781577], [52.5860595703125, 24.617057340809524], [53.25073242187499, 24.734358906253785], [52.723388671875, 24.78174733781577]]] }
  }

  before(:each) do
    @project = FactoryGirl.create(:project)
    @project.use
    @area_of_interest = FactoryGirl.create(:area_of_interest)

    header 'X-Magpie-ProjectId', @project.id
    header 'Accept', '*/*'
    header 'Content-Type', 'application/json'
  end

  it "should create polygon" do
    # Work-around to parse correctly the geometry
    post "/areas_of_interest/#{@area_of_interest.id}/polygons", { polygon: { geometry: geometry } }.to_json

    polygon = { id: AreaOfInterest.first.id, area_of_interest_id: @area_of_interest.id, geometry: geometry }
    last_response.body.should eql(polygon.to_json)
  end

  context "there is one polygon" do
    before(:each) do
      @polygon = FactoryGirl.create(:polygon, geometry: geometry)
    end

    it "should show polygon" do
      get "/polygons/#{@polygon.id}"
      polygon = { id: @polygon.id, area_of_interest_id: @polygon.area_of_interest.id, geometry: geometry }
      last_response.body.should eql(polygon.to_json)
    end

    it "should update polygon" do
      # Work-around to parse correctly the geometry
      put "/polygons/#{@polygon.id}", { polygon: { geometry: geometry } }.to_json

      polygon = { id: @polygon.id, area_of_interest_id: @polygon.area_of_interest.id, geometry: geometry }
      last_response.body.should eql(polygon.to_json)
    end
    
    it "should delete polygon" do
      delete "/polygons/#{@polygon.id}"
      Polygon.count.should eql(0)
    end
    
    it "should add a second polygon" do
      
    end
  end
end
