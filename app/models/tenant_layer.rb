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

  def self.layer_calculations(layer_id = nil)
    calculations_rel = joins(:layer => :calculations).includes(:layer => :calculations)
    unless layer_id.blank?
      calculations_rel = calculations_rel.find(layer_id)
    end
    calculations_rel.map do |tl|
      {
        :layer_id => tl.layer_id,
        :calculations => tl.layer.calculations.map do |c|
          c.attributes.select { |k,v| ['id', 'display_name'].include? k }
        end
      }
    end
  end

end
