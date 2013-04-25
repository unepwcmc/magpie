class RemoveValueJsonFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :value_json
  end
end
