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
  has_many :calculations, :through => :calculated_stats

  def calculated_stats_formatted
    calculated_stats = []
    records = self.calculations.includes(:calculated_stats)
    records.map{|r| r.layer_id}.uniq.sort.each do |layer_id|
      calculated_stats << {
        layer_id: layer_id,
        stats: records.where(:layer_id => layer_id).map do |calculation|
          {
            id: calculation.id,
            stat_id: calculation.operation_id,
            layer_id: calculation.layer_id,
            value: calculation.calculated_stats.first.value
          }
        end
      }
    end
    { calculated_stats: calculated_stats }
  end
end
