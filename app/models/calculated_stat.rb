# == Schema Information
#
# Table name: calculated_stats
#
#  id             :integer          not null, primary key
#  calculation_id :integer
#  area_id        :integer
#  value          :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class CalculatedStat < ActiveRecord::Base
  attr_accessible :area_id, :calculation_id, :value
  belongs_to :calculation
end
