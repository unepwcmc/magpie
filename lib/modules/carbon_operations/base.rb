class CarbonOperations::Base
  def self.perform layer, area_of_interest
    instance = new(layer, area_of_interest)
    instance.perform
  end

  def initialize layer, area_of_interest
    @layer = layer
    @area_of_interest = area_of_interest
  end

  private

  def results_for template_name
    query = CarbonOperations::Utils.render_query(template_name, binding)
    CarbonOperations::Utils.query_cartodb(query)
  end

  def country_iso
    @area_of_interest.properties['country_iso']
  end

  def carbon_view_name
    @layer.carbon_view
  end

  def habitat_view_name habitat
    @layer.habitat_view habitat
  end

  def the_geom
    @the_geom ||= CarbonOperations::Utils.st_makevalid(
      CarbonOperations::Utils.st_union(geometries)
    )
  end

  def geometries
    @geometries ||= begin
      polygons = @area_of_interest.polygons_as_geo_json_polygons
      polygons.map { |polygon| "ST_GeomFromGeoJSON('#{polygon.to_json}')" }
    end
  end
end
