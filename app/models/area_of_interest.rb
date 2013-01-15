class AreaOfInterest < ActiveRecord::Base
  attr_accessible :name, :workspace_id

  belongs_to :workspace

  has_many :results
  has_many :polygons, dependent: :destroy
  has_many :results, dependent: :destroy

  def fetch
    ProjectLayer.all.each do |layer|
      layer.calculations.each do |calculation|
        result = results.find_or_create_by_calculation_id(calculation.id)
        result.fetch
      end
    end
  end

  def polygons_as_geo_json
    {
      type: "FeatureCollection",
      features: polygons.map(&:to_geo_json)
    }.to_json
  end
end
