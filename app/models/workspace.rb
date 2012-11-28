class Workspace < ActiveRecord::Base
  attr_accessible :name
  has_many :areas_of_interest, :class_name => "AreaOfInterest", :dependent => :destroy

  def get_results
    areas_of_interest.each do |aoi|
      aoi.get_results if aoi.polygons.any?
    end
  end
end
