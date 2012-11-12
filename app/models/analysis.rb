class Analysis < ActiveRecord::Base
  attr_accessible :name
  has_many :areas
  has_many :polygons, :through => :areas
end
