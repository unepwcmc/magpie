class ChangeDataToGeometryInPolygons < ActiveRecord::Migration
  def up
    add_column :polygons, :geometry, :text
    execute "UPDATE polygons set geometry = data;"
    remove_column :polygons, :data
  end

  def down
    execute "ALTER TABLE polygons ADD COLUMN data json"
    remove_column :polygons, :geometry
  end
end
