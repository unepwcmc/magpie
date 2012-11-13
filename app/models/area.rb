class Area < ActiveRecord::Base
  attr_accessible :analysis_id, :name
  has_many :polygons
end
