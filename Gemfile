source 'https://rubygems.org'

gem 'rails', '3.2.22'

gem 'pg'
gem 'activerecord-postgres-hstore'

# Multi tenancy
gem 'apartment', '~>0.18.0'

gem 'rest-client'
gem 'rabl'
gem 'yajl-ruby', :require => "yajl"

gem 'bootstrap-generators', '~> 2.1.1'
gem 'simple_form'

gem 'devise', '~>2.2.5'

# Sidekiq plus monitoring
gem 'sidekiq'
gem 'slim'

# if you require 'sinatra' you get the DSL extended to Object
gem 'sinatra', '>= 1.3.0', :require => nil

gem 'httmultiparty'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'


end

gem 'jquery-rails'


gem 'rack-cors', require: 'rack/cors'

group :development do
  gem 'capistrano', '~> 3.4', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-rvm',   '~> 0.1', require: false
  gem 'capistrano-sidekiq'
  gem 'capistrano-passenger', '~> 0.1.1', require: false
end

group :staging, :production do
  gem 'exception_notification', '~>2.6.1', :require => 'exception_notifier'
end

gem 'test-unit', '~> 3.0'
group :development, :test do
  gem 'rspec-rails', '~>2.11.0'
end

group :test do
  gem "codeclimate-test-reporter"
  gem 'rack-test'
  gem 'capybara'
  gem 'headless'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'launchy'
end

gem 'test-unit', '~> 3.0'
