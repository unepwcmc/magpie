class CarbonOperations::AreaKm2 < CarbonOperations::Base
  Name = 'area_km2'
  DisplayName = 'Area'

  def perform
    results_for(:area_km2).to_json
  end
end
