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

require 'spec_helper'

describe Polygon do
  pending "add some examples to (or delete) #{__FILE__}"
end
