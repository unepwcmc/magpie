class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :display_name, :null => false
      t.string :unit

      t.timestamps
    end
  end
end
