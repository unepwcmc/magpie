class RemoveOperations < ActiveRecord::Migration
  def up
    drop_table :operations
  end

  def down
    create_table :operations do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
