Apartment.configure do |config|
  # set your options (described below) here
  config.excluded_models = ["Tenant", "Layer", "Operation", "Calculation"]
  # Dynamically get database names to migrate
  config.database_names = lambda{ Tenant.select(:name).map(&:name) }
end
