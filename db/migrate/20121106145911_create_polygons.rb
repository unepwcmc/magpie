class CreatePolygons < ActiveRecord::Migration
  def up
    create_table :polygons do |t|
      t.integer :analysis_id

      t.timestamps
    end
    execute "ALTER TABLE polygons ADD COLUMN data json"
  end
  def down
    drop_table :polygons
  end
end
