class BlueCarbonLayerOperations::AreaPercentage < BlueCarbonLayerOperations::Base
  Name = 'area_percentage'
  DisplayName = 'Percentage of Habitats'

  def perform
    results_for(:area_km2).to_json
  end
end
