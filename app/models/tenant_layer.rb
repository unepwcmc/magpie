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

  def self.layers_with_calculations(layer_id = nil)
    calculations = joins(:layer => :calculations).includes(:layer)
    unless layer_id.blank?
      calculations = calculations.where(:layer_id => layer_id)
    end
    calculations.map(&:layer)
  end

end
