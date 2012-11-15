class CreateAreasOfInterest < ActiveRecord::Migration
  def change
    create_table :areas_of_interest do |t|
      t.string :name, :null => false
      t.integer :workspace_id, :null => false
      t.boolean :is_summary, :null => false, :default => false

      t.timestamps
    end
  end
end
