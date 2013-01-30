class CreatePolygonUploads < ActiveRecord::Migration
  def change
    create_table :polygon_uploads do |t|
      t.text :filename
      t.string :state
      t.text :message
      t.integer :area_of_interest_id

      t.timestamps
    end
  end
end
