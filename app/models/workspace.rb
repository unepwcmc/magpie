# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Workspace < ActiveRecord::Base
  attr_accessible :name
  has_many :areas_of_interest, :class_name => "AreaOfInterest", :dependent => :destroy

  def get_results
    areas_of_interest.each do |aoi|
      aoi.get_results if aoi.polygons.any?
    end
  end
end
