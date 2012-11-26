Apartment.configure do |config|
  # set your options (described below) here
  config.excluded_models = ['App', 'Operation']

  # Dynamically get database names to migrate
  config.database_names = lambda { App.select(:name).map(&:name) }
end
