require "spec_helper"

describe Analysis do
  context "when created" do
    it "should have a summary area created" do
      analysis = create(:analysis)
      analysis.reload.areas.last.is_summary.should be_true
    end
  end
  context "with 2 or more areas" do
    it "orders them by created_at" do
      analysis = create(:analysis)
      area1, area2 = create(:area, :analysis_id => analysis.id), create(:area, :analysis_id => analysis)
      analysis.areas << area1
      analysis.areas << area2
      analysis.reload.areas.where(:is_summary => false).should eq([area1, area2])
    end
  end
end
