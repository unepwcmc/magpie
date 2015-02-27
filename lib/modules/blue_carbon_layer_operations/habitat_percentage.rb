class BlueCarbonLayerOperations::HabitatPercentage < BlueCarbonLayerOperations::Base
  Name = 'habitat_percentage'
  DisplayName = 'Percentage of Habitats Selected'

  def perform
    results_for(:global_percent_area).to_json
  end
end
