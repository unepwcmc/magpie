class AreaOfInterest < ActiveRecord::Base
  attr_accessible :name, :workspace_id

  belongs_to :workspace

  has_many :results
  has_many :polygons, dependent: :destroy
  has_many :results, dependent: :destroy

  def fetch
    ProjectLayer.all.each do |layer|
      layer.calculations.each do |calculation|
        Result.fetch(self, calculation)
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

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      headers, values = [], []

      FloatResult.find_all_by_area_of_interest_id(id).each do |result|
        headers << result.calculation.display_name
        values << "#{result.value}#{result.calculation.unit}"
      end

      csv << headers
      csv << values

      protected_planet_headers, protected_planet_values = ['WDPA Site Code', 'Area', 'Designation', 'Area (km2)', 'Overlap with AOI (km2)', 'Overlap with AOI %'], []

      JsonResult.find_all_by_area_of_interest_id(id).each do |result|
        if result.calculation.project_layer.class == ProtectedPlanetLayer
          JSON.parse(result.value_json).each do |protected_planet_result|
            protected_planet_result['protected_areas'].each do |protected_area|
              protected_planet_values << [
                protected_area['wdpaid'],
                protected_area['name'],
                protected_area['data_standard']['DESIG'],
                protected_area['protected_area_km2'],
                protected_area['query_area_protected_km2'],
                ( protected_area['query_area_protected_km2'] / protected_area['protected_area_km2'] ) * 100
              ]
            end
          end
        end
      end

      unless protected_planet_values.empty?
        csv << [] # Add empty line
        csv << protected_planet_headers
        protected_planet_values.each do |protected_planet_value|
          csv << protected_planet_value
        end
      end
    end
  end
end
