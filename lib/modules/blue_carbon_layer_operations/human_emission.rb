class BlueCarbonLayerOperations::HumanEmission < BlueCarbonLayerOperations::Base
  CARBON_TO_CO2_RATIO = 3.67
  CO2_PER_YEAR = 20.87

  Name = 'human_emission'
  DisplayName = 'Average Person CO2 Emissions Equivalent'

  def perform
    carbon = results_for(:total_carbon).first.try(:[], 'carbon')
    carbon_years(carbon)
  end

  private

  def carbon_years carbon
    return 0 if carbon.nil?

    co2 = carbon * CARBON_TO_CO2_RATIO
    co2 / CO2_PER_YEAR
  end
end
