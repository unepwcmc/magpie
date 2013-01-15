class Polygon < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :geometry

  belongs_to :area_of_interest

  before_validation do
    self.geometry = self.geometry.to_s
  end

  def to_geo_json
    {
      type: "Feature",
      id: id,
      properties: {},
      geometry: {
        type: "Polygon",
        coordinates: JSON.parse(geometry)[0]
      }
    }
  end

  def to_wkt
    polygon, points = JSON.parse(geometry)[0][0], []
    polygon.each { |point| points << "#{point[0]} #{point[1]}" }
    "((#{points.join(',')}))"
  end
end
