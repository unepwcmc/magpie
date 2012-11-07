class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
      t.string :name
      t.integer :type
      t.string :url

      t.timestamps
    end
  end
end
