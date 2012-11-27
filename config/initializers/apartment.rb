Apartment.configure do |config|
  # set your options (described below) here
  config.excluded_models = ['Project', 'Operation']

  # Dynamically get database names to migrate
  config.database_names = lambda { Project.select(:name).map(&:name) }
end
