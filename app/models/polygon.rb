class Polygon < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :geometry

  belongs_to :area_of_interest

  def to_geo_json
    {
      type: "Feature",
      id: id,
      properties: {},
      geometry: {
        type: "Polygon",
        coordinates: JSON.parse(geometry)
      }
    }.to_json
  end
end
