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

require 'spec_helper'

describe CalculatedStat do
  pending "add some examples to (or delete) #{__FILE__}"
end
