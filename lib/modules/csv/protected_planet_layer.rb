module CSV::ProtectedPlanetLayer
  def self.generate(aoi)
    csv = []

    values = []
    headers = [
      'WDPA Site Code',
      'Area',
      'Designation',
      'Area (km2)',
      'Overlap with AOI (km2)',
      'Overlap with AOI %'
    ]

    Result.find_all_by_area_of_interest_id(aoi.id) do |result|
      begin
        JSON.parse(result.value).each do |protected_planet_result|
          protected_planet_result['protected_areas'].each do |protected_area|
            values << [
              protected_area['wdpaid'],
              protected_area['name'],
              protected_area['data_standard']['DESIG'],
              protected_area['protected_area_km2'],
              protected_area['query_area_protected_km2'],
              ( protected_area['query_area_protected_km2'] / protected_area['protected_area_km2'] ) * 100
            ]
          end
        end
      rescue
      end
    end

    csv << [] # Add empty line
    csv << headers

    values.each do |value|
      csv << value
    end
  end
end
