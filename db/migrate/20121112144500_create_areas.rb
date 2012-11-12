class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.boolean :is_summary, :null => false, :default => false
      t.integer :analysis_id, :null => false

      t.timestamps
    end
  end
end
