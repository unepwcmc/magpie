class CreateProjectLayers < ActiveRecord::Migration
  def change
    create_table :project_layers do |t|
      t.string :display_name
      t.string :type
      t.string :tile_url
      t.boolean :is_displayed
      t.integer :provider_id, default: true

      t.timestamps
    end
  end
end
