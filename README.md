# magpie
[![Build Status](https://secure.travis-ci.org/unepwcmc/magpie.png)](https://travis-ci.org/unepwcmc/magpie)
[![Code Climate](https://codeclimate.com/github/unepwcmc/magpie/badges/gpa.svg)](https://codeclimate.com/github/unepwcmc/magpie)

## Development

### Installation

* `bundle install`, after cloning the repo.
* Copy the cartodb config file example, and fill it with the correct configuration:

        cp config/cartodb_config.yml.example config/cartodb_config.yml
        vim config/cartodb_config.yml

* Create a Postgres schema called `shared_extensions` to hold the `hstore` extension:

        psql -U postgres -d template1 -c "CREATE SCHEMA shared_extensions AUTHORIZATION postgres;"
        psql -U postgres -d template1 -c "CREATE EXTENSION IF NOT EXISTS hstore SCHEMA shared_extensions;"

* Create the development database, and run migrations: `bundle exec rake db:create && bundle exec rake db:migrate`
* Take a look at the file `db/seeds.rb`, apply changes if needed, and run `bundle exec rake db:seed`. This will
create a new admin, project, and a new database for the project, thanks to the `apartment` gem.
* Run the server with `bundle exec rails s`

### Database Switching

We're using the `apartment` gem for PostgreSQL schema based multi tenancy. Most important consequences of that are:

* a new schema is created for each application (with the same name). This is hooked as an `after_create` block, but can also be done manually if needed:

        Apartment::Database.create('database_name')

  this also runs the migrations on the new schema.

* schemas are switched per request based on the request header `X-Magpie-ProjectId`. If you need to switch the schema in console use:

        Apartment::Database.switch('project_name')

* migrations should run on all schemas, therefore make sure you use:

        bundle exec rake apartment:migrate

### Sidekiq background jobs
Sidekiq is used for background workers, currently just for cartodb uploading. To run them in development, do

    # Fire up a redis server
    redis-server /usr/local/etc/redis.conf
    # Start sidekiq
    bundle exec sidekiq

## Deployment

### Database

The database user needs to be able to create schemas, therefore:

    GRANT CREATE ON DATABASE magpie_staging TO wcmc;

### CORS

To enable cross domain requests in development, you can use rack-cors middleware.

Staging and production environments should have the appropriate headers defined in Apache config:

    <VirtualHost *:80>
      Header set Access-Control-Allow-Origin *
      Header set Access-Control-Allow-Methods "POST, GET, OPTIONS"
      Header set Access-Control-Allow-Headers "X-Requested-With, X-Prototype-Version"
      Header set Access-Control-Max-Age 1728000
      ...

### Sidekiq background jobs
We're using sidekiq for our background job processing (at the time of writing, just for cartodb uploads). Manage the deployment using the available cap commands, use this for a list:

    cap -vT | grep sidekiq

### STDERR is being flooded when using Postgres

If you are using Postgres and have foreign key constraints, the truncation strategy will cause a lot of extra noise to appear on STDERR (in the form of "NOTICE truncate cascades" messages). To silence these warnings set the following log level in your `postgresql.conf` file:

```ruby
client_min_messages = warning
```

## API calls

### Resource: polygon

* POST
        curl localhost:3000/polygons --data "polygon[data]=[50,50]"

        {"polygon":{"analysis_id":7,"created_at":"2012-11-07T14:11:57Z","data":"[50,50]","id":2,"updated_at":"2012-11-07T14:11:57Z"},"analysis":{"created_at":"2012-11-07T14:11:56Z","id":7,"name":"My Analysis","updated_at":"2012-11-07T14:11:56Z"}}

* PUT
        curl localhost:3000/polygons/2 --data "polygon[data]=[50,500]" -X PUT

        {"analysis_id":7,"created_at":"2012-11-07T14:11:57Z","data":"[50,500]","id":2,"updated_at":"2012-11-07T14:13:13Z"}

* GET
        curl localhost:3000/polygons/2

        {"analysis_id":7,"created_at":"2012-11-07T14:11:57Z","data":"[50,500]","id":2,"updated_at":"2012-11-07T14:13:13Z"}

### Resource: analysis

* PUT
        curl localhost:3000/analyses/7 --data "analysis[name]=Good stuff" -X PUT

        {"created_at":"2012-11-07T14:11:56Z","id":7,"name":"Good stuff","updated_at":"2012-11-07T14:15:56Z"}

* GET
        curl localhost:3000/analyses/7

        {"created_at":"2012-11-07T14:11:56Z","id":7,"name":"Good stuff","updated_at":"2012-11-07T14:15:56Z"}

## Generated documentation
To generate the api documentation from specs:
```
  rspec spec --format RspecApiDocumentation::ApiFormatter
```
To generate the coverage report: coverage report is generated automatically when you run:
```
  rspec spec
```
