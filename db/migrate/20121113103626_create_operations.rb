class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :name

      t.timestamps
    end
  end
end
