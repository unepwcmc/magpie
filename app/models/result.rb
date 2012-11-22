# == Schema Information
#
# Table name: results
#
#  id                  :integer          not null, primary key
#  value               :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  area_of_interest_id :integer
#  calculation_id      :integer
#

class Result < ActiveRecord::Base
  attr_accessible :value
  belongs_to :calculation
  belongs_to :area_of_interest

  def get
    #debugger
    #value= RestClient.get "http://raster-stats.unep-wcmc.org/rasters/#{self.calculation.app_layer.provider_id}/operations/#{self.calculation.operation.name}", {:params => {:polygon => self.area_of_interest.polygons.first.geometry}}["value"]
    save
  end
end
