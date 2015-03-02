Apartment.configure do |config|
  # set your options (described below) here
  config.excluded_models = ['Project', 'Admin']

  # Dynamically get database names to migrate
  config.database_names = lambda { Project.select(:name).map(&:name) }

  config.persistent_schemas = ['shared_extensions']
end
