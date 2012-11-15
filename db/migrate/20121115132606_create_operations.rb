class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
