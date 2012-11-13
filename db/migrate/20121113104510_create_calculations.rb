class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :display_name
      t.integer :operation_id
      t.integer :layer_id

      t.timestamps
    end
  end
end
