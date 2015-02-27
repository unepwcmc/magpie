class BlueCarbonLayerOperations::TotalCarbon < BlueCarbonLayerOperations::Base
  Name = 'total_carbon'
  DisplayName = 'Total Carbon'

  def perform
    results_for(:total_carbon).first.try(:[], 'carbon') || 0
  end
end
