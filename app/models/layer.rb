# == Schema Information
#
# Table name: public.layers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  type       :integer
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Layer < ActiveRecord::Base
  attr_accessible :name, :type, :url
  has_many :calculations
  has_many :calculated_stats, :through => :calculations
end
