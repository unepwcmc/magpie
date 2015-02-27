class BlueCarbonLayerOperations::Base
  def self.perform area_of_interest
    instance = new(area_of_interest)
    instance.perform
  end

  def initialize area_of_interest
    @area_of_interest = area_of_interest
  end

  private

  def results_for template_name
    query = BlueCarbonLayerOperations::Utils.render_query(template_name, binding)
    BlueCarbonLayerOperations::Utils.query_cartodb(query)
  end

  def country_name
    @area_of_interest.properties['country']
  end

  def carbon_view_name
    "blueforest_carbon_#{Rails.env}_#{country_name}"
  end

  def the_geom
    @the_geom ||= BlueCarbonLayerOperations::Utils.st_makevalid(
      BlueCarbonLayerOperations::Utils.st_union(geometries)
    )
  end

  def geometries
    @geometries ||= begin
      polygons = @area_of_interest.polygons_as_geo_json_polygons
      polygons.map { |polygon| "ST_GeomFromGeoJSON('#{polygon.to_json}')" }
    end
  end
end
