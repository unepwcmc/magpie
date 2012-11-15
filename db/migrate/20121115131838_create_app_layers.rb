class CreateAppLayers < ActiveRecord::Migration
  def change
    create_table :app_layers do |t|
      t.string :display_name, :null => false
      t.string :type, :null =>false
      t.integer :provider_id, :null => false
      t.string :tile_url, :null => false
      t.boolean :is_displayed, :null => false, :default => true

      t.timestamps
    end
  end
end
