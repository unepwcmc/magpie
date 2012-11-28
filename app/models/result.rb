class Result < ActiveRecord::Base
  attr_accessible :value
  belongs_to :calculation
  belongs_to :area_of_interest

  def get
    response = JSON.parse(RestClient.get "http://raster-stats.unep-wcmc.org/rasters/#{self.calculation.project_layer.provider_id}/operations/#{self.calculation.operation.name}", {:params => {:polygon => self.area_of_interest.polygons.first.geom_as_GeoJSON}})
    if response
      self.value= response["value"].to_f
    else
      self.value = -1
    end
    self.save
  end
end
