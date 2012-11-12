class Area < ActiveRecord::Base
  attr_accessible :analysis_id, :is_summary, :name
  has_many :polygons
end
