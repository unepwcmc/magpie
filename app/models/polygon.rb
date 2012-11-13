# == Schema Information
#
# Table name: polygons
#
#  id         :integer          not null, primary key
#  area_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  data       :json
#

class Polygon < ActiveRecord::Base
  attr_accessible :area_id, :data
end
