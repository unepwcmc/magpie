class CarbonOperations::AreaPercentage < CarbonOperations::Base
  Name = 'area_percentage'
  DisplayName = 'Percentage of Habitats'

  def perform
    results_for(:area_km2).to_json
  end
end
