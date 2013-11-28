source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

gem 'rvm-capistrano'


gem 'rest-client'
gem 'rabl'
gem 'yajl-ruby', :require => "yajl"

gem 'bootstrap-generators', '~> 2.1', git: 'git://github.com/decioferreira/bootstrap-generators.git'
gem 'simple_form'

gem 'devise'

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

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Multi tenancy
gem 'apartment'

gem 'rack-cors', require: 'rack/cors'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'brightbox', '>= 2.3.9'
end

# To use debugger
gem 'ruby-debug19', :require => 'ruby-debug', group: :development

group :staging, :production do
  gem 'exception_notification', :require => 'exception_notifier'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'rack-test'
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'headless'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'launchy'
end
