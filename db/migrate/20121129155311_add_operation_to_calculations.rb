class AddOperationToCalculations < ActiveRecord::Migration
  def up
    remove_column :calculations, :operation_id
    add_column :calculations, :operation, :string
  end

  def down
    add_column :calculations, :operation_id, :integer
    remove_column :calculations, :operation
  end
end
