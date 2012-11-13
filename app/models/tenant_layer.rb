# == Schema Information
#
# Table name: tenant_layers
#
#  id         :integer          not null, primary key
#  layer_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TenantLayer < ActiveRecord::Base
  attr_accessible :layer_id

  belongs_to :layer
end
