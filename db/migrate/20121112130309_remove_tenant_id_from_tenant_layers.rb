class RemoveTenantIdFromTenantLayers < ActiveRecord::Migration
  def up
    remove_column :tenant_layers, :tenant_id
  end

  def down
    add_column :tenant_layers, :tenant_id, :integer
  end
end
