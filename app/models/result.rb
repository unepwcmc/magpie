class Result < ActiveRecord::Base
  attr_accessible :value

  belongs_to :calculation
  belongs_to :area_of_interest

  def fetch
    if area_of_interest.polygons.count > 0
      response = RestClient.get("http://raster-stats.unep-wcmc.org/rasters/#{calculation.project_layer.provider_id}/operations/#{calculation.operation}", params: {polygon: area_of_interest.polygons_as_geo_json})
      response_json = JSON.parse(response)
      self.value = response_json["value"].to_f
      save
    end
  end
end
