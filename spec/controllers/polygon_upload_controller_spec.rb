require 'spec_helper'

describe PolygonUploadsController do

=begin
  # This would work if we can work out in tests how to get around the
  # project requirement for routes 
  describe "GET 'show'" do
    context "a polygon upload exists" do
      before(:all) do
        @polygon_upload = FactoryGirl.create :polygon_upload
      end

      it "returns http success" do
        get 'show', :id => @polygon_upload.id
        response.should be_success
        response.body.should eq('fdsf')
      end
    end
  end
=end

end
