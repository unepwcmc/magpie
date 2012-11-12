require "spec_helper"

resource "Analysis" do

  get "/analyses/:id" do
    parameter :id, "Analysis ID"

    let(:analysis) { create(:analysis) }
    let(:id) { analysis.id }

    example_request "Getting a specific analysis" do
      explanation "curl localhost:3000/analyses/2"
      do_request
      status.should == 200
      response_body.should be_json_eql analysis.to_json
    end
  end

  put "/analyses/:id" do
    parameter :id, "Analysis id"
    parameter :name, "Analysis name"
    let(:analysis) { create(:analysis) }
    let(:id) { analysis.id }
    let(:name) { 'Even more interesting analysis' }
    scope_parameters :analysis, :all
    example_request "Updating an existing analysis" do
      do_request
      status.should == 200
      response_body.should be_json_eql(params["analysis"].to_json)
    end
  end

end
