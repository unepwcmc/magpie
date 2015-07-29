class BlueCarbonLayer < ProjectLayer
  def self.get_operations
    super('carbon_operations')
  end

  def self.fetch_result(operation, area_of_interest)
    "CarbonOperations::#{operation.to_s.classify}".constantize.perform(self, area_of_interest)
  end

  def self.carbon_view
    "bc_carbon_#{Rails.env}"
  end

  def self.habitat_view habitat
    "bc_#{habitat}_#{Rails.env}"
  end
end
