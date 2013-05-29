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

  context 'area_of_interest for a project with three statistics' do
    before(:each) do
      test_layer = FactoryGirl.create(:test_layer)
      FactoryGirl.create(:statistic,
        display_name: "Operation 1",
        project_layer: test_layer,
        operation: 'operation_1'
      )
      FactoryGirl.create(:statistic,
        display_name: "Operation 2",
        project_layer: test_layer,
        operation: 'operation_2'
      )
      FactoryGirl.create(:statistic,
        display_name: "Operation 3",
        project_layer: test_layer,
        operation: 'operation_2'
      )

      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')

      geometry = { type: "Polygon", coordinates: [[[52, 24], [53, 24], [52, 25], [52, 24]]] }
      polygon = FactoryGirl.create(:polygon,
        geometry: geometry,
        area_of_interest: @area_of_interest
      )
    end

    context 'requesting all (no filter)' do
      before(:each) do
        get "/areas_of_interest/#{@area_of_interest.id}"
        @json_response = JSON.parse(last_response.body)
      end
      it 'calculates all statistics' do
        @area_of_interest.results.count.should eql(3)
      end
      it 'returns all statistics' do
        @json_response['results'].length.should eql(3)
      end
    end

    context 'requesting one statistic' do
      before(:each) do
        get "/areas_of_interest/#{@area_of_interest.id}", {statistics: ["Operation 2"]}
        @json_response = JSON.parse(last_response.body)
      end
      it 'only calculates that statistic' do
        @area_of_interest.results.count.should eql(1)
      end
      it 'returns only that statistic' do
        @json_response['results'].first['display_name'].should eql 'Operation 2'
      end
    end

    context 'requesting two statistics' do
      before(:each) do
        get "/areas_of_interest/#{@area_of_interest.id}", {statistics: ["Operation 1", "Operation 2"]}
        @json_response = JSON.parse(last_response.body)
      end

      it 'only calculates those statistics' do
        @area_of_interest.results.count.should eql(2)
      end

      it 'returns only those statistics' do
        @json_response['results'].each do |result|
          ["Operation 1", "Operation 2"].should include(result['display_name'])
        end
      end
    end
  end

  context 'the area_of_interest has statistics without calculated results' do
    before(:each) do
      test_layer = FactoryGirl.create(:test_layer)
      FactoryGirl.create(:statistic,
        display_name: "Operation 1",
        project_layer: test_layer,
        operation: 'operation_1'
      )

      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')

      geometry = { type: "Polygon", coordinates: [[[52, 24], [53, 24], [52, 25], [52, 24]]] }
      polygon = FactoryGirl.create(:polygon,
        geometry: geometry,
        area_of_interest: @area_of_interest
      )

      get "/areas_of_interest/#{@area_of_interest.id}"
      json_response = JSON.parse(last_response.body)
    end

    it 'calculates those results' do
      @area_of_interest.results.count.should eql(1)
    end
  end

  context 'the area_of_interest with calculated results' do
    before(:each) do
      test_layer = FactoryGirl.create(:test_layer)
      statistic = FactoryGirl.create(:statistic,
        display_name: "Operation 1",
        project_layer: test_layer,
        operation: 'operation_1'
      )

      @area_of_interest = FactoryGirl.create(:area_of_interest, name: 'My Area')

      geometry = { type: "Polygon", coordinates: [[[52, 24], [53, 24], [52, 25], [52, 24]]] }
      polygon = FactoryGirl.create(:polygon,
        geometry: geometry,
        area_of_interest: @area_of_interest
      )

      @correct_value = "pre-calculated-value"
      @existing_result_attributes = FactoryGirl.create(:result,
        value: @correct_value,
        statistic: statistic, 
        area_of_interest: @area_of_interest
      ).attributes
    end

    context "when requested" do
      before(:each) do
        get "/areas_of_interest/#{@area_of_interest.id}"
        @json_response = JSON.parse(last_response.body)
      end

      it 'does not calculate the results again' do
        # Flatten dates
        result_attributes = @area_of_interest.results.first.attributes
        result_attributes = result_attributes.map(&:to_s)
        @existing_result_attributes = @existing_result_attributes.map(&:to_s)

        result_attributes.should eql(@existing_result_attributes)
      end

      it 'returns the correct results' do
        @json_response['results'].first['value'].should eql(@correct_value)
      end

      context 'when the polygons change' do
        before (:each) do
          geometry = { type: "Polygon", coordinates: [[[52, 24], [54, 24], [52, 25], [52, 24]]] }
          polygon = FactoryGirl.create(:polygon,
            geometry: geometry,
            area_of_interest: @area_of_interest
          )

          get "/areas_of_interest/#{@area_of_interest.id}"
          @json_response = JSON.parse(last_response.body)
        end

        it 'calculates the results again' do
          @area_of_interest.results.first.attributes.should_not eql(@existing_result_attributes)
        end

        it 'returns the correct results' do
          @json_response['results'].first['value'].should eql(1)
        end
      end
    end
  end
end
