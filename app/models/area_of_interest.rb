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

class AreaOfInterest < ActiveRecord::Base
  attr_accessible :name, :workspace_id
  has_many :results
  belongs_to :workspace
end
