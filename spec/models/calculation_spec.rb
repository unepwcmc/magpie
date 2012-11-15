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

require 'spec_helper'

describe Calculation do
  pending "add some examples to (or delete) #{__FILE__}"
end
