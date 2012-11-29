# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Apartment::Database.switch()

Admin.create(email: 'decio.ferreira@unep-wcmc.org', password: 'decioferreira', password_confirmation: 'decioferreira')

Project.create(name: 'carbon')

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

ProjectLayer.all.each do |layer|
  calculation = Calculation.new(display_name: "#{layer.display_name} sum")
  calculation.project_layer = layer
  calculation.operation = 'sum'
  calculation.save
end
