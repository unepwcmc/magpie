# magpie

## Development
We're using the apartment gem for PostgreSQL schema based multi tenancy. Most important consequences of that are:
* a new schema is created for each application (with the same name). This is hooked as an after_create block, but can also be done manually if needed:
        Apartment::Database.create('database_name')
  this also runs the migrations on the new schema.
* schemas are switched per request based on subdomain. If you need to switch the schema in console use:
        Apartment::Database.switch('database_name')
* migrations should run on all schemas, therefore make sure you use:
        rake apartment:migrate
