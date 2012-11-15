class CreatePolygons < ActiveRecord::Migration
  def change
    create_table :polygons do |t|
      t.text :geometry, :null => false
      t.integer :area_id, :null => false

      t.timestamps
    end
  end
end
