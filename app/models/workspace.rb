class Workspace < ActiveRecord::Base
  attr_accessible :name

  has_many :areas_of_interest, :class_name => "AreaOfInterest", dependent: :destroy

  after_find do
    areas_of_interest.each { |aoi| aoi.fetch }
  end
end
