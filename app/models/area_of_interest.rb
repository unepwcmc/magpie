class AreaOfInterest < ActiveRecord::Base
  attr_accessible :name, :workspace_id

  belongs_to :workspace

  has_many :results
  has_many :polygons, dependent: :destroy
  has_many :results, dependent: :destroy

  def generate_results only_statistics = []
    return unless self.polygons.length > 0
    filter_statistics = only_statistics.length > 0

    ProjectLayer.all.each do |layer|
      layer.statistics.each do |statistic|
        if !filter_statistics || only_statistics.include?(statistic.display_name)
          self.generate_result(statistic)
        end
      end
    end
  end

  def generate_result(statistic)
    result = self.find_or_create_result_for_statistic(statistic)

    unless result.has_more_recent_value_than? self.most_recent_polygon_updated_at
      begin
        result.fetch
      rescue TimeoutError => e
        result.errors[:base] <<e.message
      end
    end
  end

  def find_or_create_result_for_statistic(statistic)
    result = self.results.find(:first, conditions: { statistic_id: statistic.id })

    unless result
      result = Result.create(
        area_of_interest: self,
        statistic: statistic
      )
    end

    return result
  end

  def polygons_as_geo_json
    {
      type: "FeatureCollection",
      features: polygons.map(&:to_geo_json)
    }.to_json
  end

  def polygons_as_geo_json_multipolygon
    the_polygons = polygons.map do |polygon|
      geo_json = JSON.parse(polygon.geometry)
      geo_json["coordinates"]
    end
    {
      type: "MultiPolygon",
      coordinates: the_polygons
    }.to_json
  end

  def polygons_as_geo_json_polygons
    the_polygons = polygons.map do |polygon|
      geo_json = JSON.parse(polygon.geometry)
      {
        type: "Polygon",
        coordinates: geo_json["coordinates"]
      }
    end
    the_polygons
  end

  def to_wkt
    polygons.map(&:to_wkt)
  end

  def most_recent_polygon_updated_at
    polys = polygons.select(:updated_at).order("updated_at DESC").limit(1)
    polys.first.updated_at
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      headers, values = [], []

      Result.find_all_by_area_of_interest_id(id).each do |result|
        # Ignore JSON values
        begin
          JSON.parse(result.value)
        rescue
          headers << result.statistic.display_name
          values << "#{result.value.to_f.round(2)} #{result.statistic.unit}"
        end
      end

      csv << headers
      csv << values


      bluecarbon_headers, bluecarbon_values = ["Habitat"], []
      bluecarbon_habitats = {}

      Result.find_all_by_area_of_interest_id(id).each do |result|
        case result.statistic.project_layer
        when ProtectedPlanetLayer
        when BlueCarbonLayer
          begin
            JSON.parse(result.value).each do |row|
              habitat   = row["habitat"]

              operation = result.statistic.operation
              unit      = result.statistic.unit

              bluecarbon_headers << operation

              bluecarbon_habitats[habitat] ||= []
              bluecarbon_habitats[habitat] << "#{row[operation].to_f.round(2)} #{unit}"
            end
          rescue
          end
        end
      end

      bluecarbon_habitats.each do |habitat, results|
        bluecarbon_values << [habitat, *results]
      end

      unless bluecarbon_values.empty?
        csv << []
        csv << bluecarbon_headers.uniq
        bluecarbon_values.each do |bluecarbon_value|
          csv << bluecarbon_value
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
