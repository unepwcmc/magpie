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

## API calls

###Resource: polygon

* POST
        curl localhost:3000/polygons --data "polygon[data]=[50,50]"

        {"polygon":{"analysis_id":7,"created_at":"2012-11-07T14:11:57Z","data":"[50,50]","id":2,"updated_at":"2012-11-07T14:11:57Z"},"analysis":{"created_at":"2012-11-07T14:11:56Z","id":7,"name":"My Analysis","updated_at":"2012-11-07T14:11:56Z"}}

* PUT
        curl localhost:3000/polygons/2 --data "polygon[data]=[50,500]" -X PUT

        {"analysis_id":7,"created_at":"2012-11-07T14:11:57Z","data":"[50,500]","id":2,"updated_at":"2012-11-07T14:13:13Z"}

* GET
        curl localhost:3000/polygons/2

        {"analysis_id":7,"created_at":"2012-11-07T14:11:57Z","data":"[50,500]","id":2,"updated_at":"2012-11-07T14:13:13Z"}

###Resource: analysis

* PUT
        curl localhost:3000/analyses/7 --data "analysis[name]=Good stuff" -X PUT

        {"created_at":"2012-11-07T14:11:56Z","id":7,"name":"Good stuff","updated_at":"2012-11-07T14:15:56Z"}

* GET
        curl localhost:3000/analyses/7

        {"created_at":"2012-11-07T14:11:56Z","id":7,"name":"Good stuff","updated_at":"2012-11-07T14:15:56Z"}