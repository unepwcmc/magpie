class BlueForestLayer < ProjectLayer
  def self.get_operations
    super('carbon_operations')
  end

  def self.fetch_result(operation, area_of_interest)
    "CarbonOperations::#{operation.to_s.classify}".constantize.perform(self, area_of_interest)
  end

  def self.carbon_view country_name
    "blueforest_carbon_#{Rails.env}_#{country_name}"
  end

  def self.habitat_view habitat, country_name
    "blueforest_#{habitat}_#{Rails.env}_#{country_name}"
  end
end
