require 'simplecov'
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
# Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.create(:tenant, :name => 'carbon')
    DatabaseCleaner.strategy = :transaction
  end

  config.after(:suite) do
    ActiveRecord::Base.connection.execute('DROP SCHEMA carbon CASCADE')
  end

  config.before(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end
  
  config.after(:each) do
    DatabaseCleaner.clean
  end

end

def public_scope
  Apartment::Database.switch()
  yield
  begin
    Apartment::Database.switch('carbon')
  rescue Apartment::SchemaNotFound
    FactoryGirl.create(:tenant, :name => 'carbon')
    Apartment::Database.switch('carbon')
  end
end
