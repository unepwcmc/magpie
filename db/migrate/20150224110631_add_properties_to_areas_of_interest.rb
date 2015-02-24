class AddPropertiesToAreasOfInterest < ActiveRecord::Migration
  def change
    add_column :areas_of_interest, :properties, :hstore
  end
end
