# == Schema Information
#
# Table name: calculations
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  unit         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :unit
end
