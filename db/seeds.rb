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

raster_layer = RasterLayer.new(
  display_name: 'Mangroves',
  is_displayed: true,
  provider_id: 1
)
raster_layer.tile_url = 'http://'
raster_layer.save

raster_layer = RasterLayer.new(
  display_name: 'Seagrass',
  is_displayed: true,
  provider_id: 2
)
raster_layer.tile_url = 'http://'
raster_layer.save

ProjectLayer.all.each do |layer|
  statistic = Statistic.new(display_name: "#{layer.display_name} sum")
  statistic.project_layer = layer
  statistic.operation = 'sum'
  statistic.save
end
