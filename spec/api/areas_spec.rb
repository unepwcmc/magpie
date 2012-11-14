require "spec_helper"

resource "Area" do

  get "/areas/:id" do
    parameter :id, "Area ID"

    let(:analysis){ create(:analysis) }
    let(:area) { create(:area, :analysis_id => analysis.id) }

    example_request "Getting a specific area" do
      explanation "curl localhost:3000/areas/2"
      @id = area.id 
      do_request(:id => area.id)
      status.should == 200
      response_body.should be_json_eql area.to_json
    end
    example_request "Getting an area which does not exist" do
      do_request(:id => -1)
      status.should == 200
      response_body.should be_json_eql({:error => 'Resource not found'}.to_json)
    end
  end

  put "/areas/:id" do
    parameter :id, "Area id"
    parameter :name, "Area name"
    let(:analysis) { create(:analysis) }
    let(:area) { create(:area, :analysis_id => analysis.id) }
    let(:id) { area.id }
    let(:name) { 'Even more interesting area' }
    scope_parameters :area, :all
    example_request "Updating an existing area" do
      do_request
      status.should == 200
      response_body.should be_json_eql(params["area"].to_json).
        excluding('analysis_id').excluding('is_summary')
    end
  end

  get "/areas/:id/calculated_stats" do
    parameter :id, "Area id"
    let(:analysis) { create(:analysis) }
    let(:area) { create(:area, :analysis_id => analysis.id) }
    let(:id) { area.id }
    let(:calculated_stat) { create(:calculated_stat, :area_id => id) }

    example_request "Getting the calculated stats for an existing area" do
      do_request
      status.should == 200
      response_body.should be_json_eql(area.calculated_stats_formatted.to_json)
    end
  end
end
