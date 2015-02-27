class BlueCarbonLayerOperations::AreaKm2 < BlueCarbonLayerOperations::Base
  Name = 'area_km2'
  DisplayName = 'Area'

  def perform
    results_for(:area_km2).to_json
  end
end
