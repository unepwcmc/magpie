require 'simplecov'
SimpleCov.start

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Add this to load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Capybara::DSL

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    #Project.all.each do |project|
    #  ActiveRecord::Base.connection.execute("DROP SCHEMA #{project.name} CASCADE;")
    #end
    Apartment::Database.switch()
    DatabaseCleaner.clean
  end
end

module TestLayerOperations
  module Operation1
    Name = 'operation_1'
    DisplayName = 'Operation I'

    def self.perform area_of_interest
      return 1
    end
  end

  module Operation2
    Name = 'operation_2'
    DisplayName = 'Operation II'

    def self.perform area_of_interest
      return 2
    end
  end
end

class TestLayer < ProjectLayer
  ProjectLayer::PROJECT_LAYER_CLASSES = ProjectLayer::PROJECT_LAYER_CLASSES.push('TestLayer')

  def self.get_operations
    operations = []
    [TestLayerOperations::Operation1,
      TestLayerOperations::Operation2].each_with_index do |operation, i|
      operations << {
        'id' => i,
        'name' => operation::Name,
        'display_name' => operation::DisplayName
      }
    end
  end
end
