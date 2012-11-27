# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Apartment::Database.switch()

Project.create(name: 'carbon')

Operation.create(name: 'sum')
Operation.create(name: 'avg')

Apartment::Database.switch('carbon')

ProjectLayer.create(
  display_name: 'Mangroves', 
  type: 'RasterLayer',
  tile_url: 'http://',
  is_displayed: true,
  provider_id: 1
)

ProjectLayer.create(
  display_name: 'Seagrass', 
  type: 'RasterLayer',
  tile_url: 'http://',
  is_displayed: true,
  provider_id: 2
)

Operation.all.each do |operation|
  ProjectLayer.all.each do |layer|
    calculation = Calculation.new(display_name: "#{layer.display_name} #{operation.name}")
    calculation.project_layer = layer
    calculation.operation = operation
    calculation.save
  end
end
