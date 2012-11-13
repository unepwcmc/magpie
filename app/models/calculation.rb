# == Schema Information
#
# Table name: public.calculations
#
#  id           :integer          not null, primary key
#  display_name :string(255)
#  operation_id :integer
#  layer_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Calculation < ActiveRecord::Base
  attr_accessible :display_name, :layer_id, :operation_id
  belongs_to :layer
  belongs_to :operation
  has_many :calculated_stats
end
