require 'spec_helper'

describe AreaOfInterest do
  describe '.most_recent_polygon_at' do
    context 'on an area of interest with 2 polygons' do
      before(:each) do
        @area_of_interest = FactoryGirl.create(:area_of_interest)
        @most_recent_polygon = FactoryGirl.create(:polygon,
          area_of_interest: @area_of_interest,
          updated_at: 2.days.ago
        )
        older_polygon = FactoryGirl.create(:polygon,
          area_of_interest: @area_of_interest,
          updated_at: 5.days.ago
        )
      end
      it 'returns the updated_at time of the most recent polygon' do
        @area_of_interest.most_recent_polygon_updated_at.should eql(@most_recent_polygon.updated_at)
      end
    end
  end
end
