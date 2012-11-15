class AddAppLayerIdAndOperationIdToCalculations < ActiveRecord::Migration
  def change
    add_column :calculations, :app_layer_id, :integer
    add_column :calculations, :operation_id, :integer
  end
end
