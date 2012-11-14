# == Schema Information
#
# Table name: areas
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  is_summary  :boolean          default(FALSE), not null
#  analysis_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Area < ActiveRecord::Base
  attr_accessible :analysis_id, :name
  has_many :polygons
  has_many :calculated_stats
  has_many :calculations, :through => :calculated_stats, :include => :calculated_stats
  has_many :layers, :through => :calculations, :uniq => true
end
