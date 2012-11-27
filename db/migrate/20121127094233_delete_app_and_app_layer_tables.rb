class DeleteAppAndAppLayerTables < ActiveRecord::Migration
  def up
    drop_table :apps
    drop_table :app_layers

    rename_column :calculations, :app_layer_id, :project_layer_id
  end

  def down
    create_table :apps do |t|
      t.string :name, :null => false

      t.timestamps
    end

    create_table :app_layers do |t|
      t.string :display_name, :null => false
      t.string :type, :null =>false
      t.integer :provider_id, :null => false
      t.string :tile_url, :null => false
      t.boolean :is_displayed, :null => false, :default => true

      t.timestamps
    end

    rename_column :calculations, :app_layer_id, :project_layer_id
  end
end
