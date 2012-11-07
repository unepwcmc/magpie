class CreateTenantLayers < ActiveRecord::Migration
  def change
    create_table :tenant_layers do |t|
      t.integer :tenant_id
      t.integer :layer_id

      t.timestamps
    end
  end
end
