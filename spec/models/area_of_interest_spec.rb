# == Schema Information
#
# Table name: areas_of_interest
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  workspace_id :integer          not null
#  is_summary   :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe AreaOfInterest do
  pending "add some examples to (or delete) #{__FILE__}"
end
