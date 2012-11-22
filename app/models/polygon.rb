# == Schema Information
#
# Table name: polygons
#
#  id                  :integer          not null, primary key
#  geometry            :text             not null
#  area_of_interest_id :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Polygon < ActiveRecord::Base
  attr_accessible :area_of_interest_id, :geometry
  belongs_to :area_of_interest

  def geom_as_GeoJSON
    {
      type: "FeatureCollection",
      features: [{
        type: "Feature",
        id: self.id,
        geometry: {
          type: "MultiPolygon",
          coordinates: self.geometry
        }
      }]
    }.to_json
  end
end
