class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.float :value

      t.timestamps
    end
  end
end
