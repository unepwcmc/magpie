class Polygon < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :geometry
  belongs_to :area_of_interest

  def geom_as_GeoJSON
    {
      type: "FeatureCollection",
      features: [{
        type: "Feature",
        id: self.id,
        properties: {},
        geometry: {
          type: "MultiPolygon",
          coordinates: JSON.parse(self.geometry)
        }
      }]
    }.to_json
  end
end
