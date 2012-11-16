# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#ActiveRecord::Base.transaction do

  Apartment::Database.switch()
  if App.find_by_name('carbon').nil?
    App.create(:name => 'carbon')
  end
  sum = Operation.create(
    :name => 'SUM'
  )
  avg = Operation.create(
    :name => 'AVG'
  )
  Apartment::Database.switch('carbon')
  mangroves = AppLayer.create(
    :display_name => 'Mangroves', 
    :type => 'RasterLayer',
    :provider_id => 1,
    :tile_url => 'TODO',
    :is_displayed => true
  )
  seagrass = AppLayer.create(
    :display_name => 'Seagrass',
    :type => 'RasterLayer',
    :provider_id => 2,
    :tile_url => 'TODO',
    :is_displayed => true
  )
  [sum, avg].each do |op|
    [mangroves, seagrass].each do |l|
      c = Calculation.new(:display_name => "#{l.display_name} #{op.name}")
      c.app_layer = l
      c.operation = op
      c.save
    end
  end
#end