class CreateCalculatedStats < ActiveRecord::Migration
  def change
    create_table :calculated_stats do |t|
      t.integer :calculation_id
      t.integer :area_id
      t.float :value

      t.timestamps
    end
  end
end
