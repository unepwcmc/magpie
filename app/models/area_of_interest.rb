class AreaOfInterest < ActiveRecord::Base
  attr_accessible :name, :workspace_id

  belongs_to :workspace

  has_many :results
  has_many :polygons, dependent: :destroy
  has_many :results, dependent: :destroy

  def fetch
    ProjectLayer.all.each do |layer|
      layer.calculations.each do |calculation|
        Result.generate(self, calculation)
      end
    end
  end

  def polygons_as_geo_json
    {
      type: "FeatureCollection",
      features: polygons.map(&:to_geo_json)
    }.to_json
  end

  def to_wkt
    polygons.map(&:to_wkt)
  end
end
