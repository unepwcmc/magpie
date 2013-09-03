module CSV::ProtectedPlanetLayer
  def self.generate(aoi)
    csv = []

    bluecarbon_headers, bluecarbon_values = ["Habitat"], []
    bluecarbon_habitats = {}

    Result.find_all_by_area_of_interest_id(aoi.id).each do |result|
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
  end
end
