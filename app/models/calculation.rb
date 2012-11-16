# == Schema Information
#
# Table name: calculations
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  unit         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  app_layer_id :integer
#  operation_id :integer
#

class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :unit, :app_layer_id, :operation_id
  belongs_to :app_layer
  belongs_to :operation
end
