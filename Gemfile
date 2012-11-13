source 'https://rubygems.org'

gem 'rails', '3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'rails-api'
gem 'rest-client'

# storage
gem 'pg'

# multi tenancy
gem 'apartment'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


group :staging, :production do
  gem 'exception_notification', :require => 'exception_notifier'
  gem 'newrelic_rpm'
end

group :development do
  # Deploy with Capistrano
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'brightbox', '>=2.3.9'
end

group :test, :development do
  gem "rspec-rails"
  gem "database_cleaner"
end

group :test do
  gem 'rspec_api_documentation'
  gem "factory_girl_rails", "~> 4.0"
  gem "json_spec"
  gem 'simplecov', :require => false
end
