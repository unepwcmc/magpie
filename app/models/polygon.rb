# == Schema Information
#
# Table name: polygons
#
#  id         :integer          not null, primary key
#  geometry   :text             not null
#  area_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Polygon < ActiveRecord::Base
  attr_accessible :area_id, :geometry
end
