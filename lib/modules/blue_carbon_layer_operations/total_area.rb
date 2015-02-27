class BlueCarbonLayerOperations::TotalArea < BlueCarbonLayerOperations::Base
  Name = 'total_area'
  DisplayName = 'Total Area'

  def perform
    results_for(:total_area).first.try(:[], 'area') || 0
  end
end
