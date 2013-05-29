class AddValueUpdatedAtToResult < ActiveRecord::Migration
  def change
    add_column :results, :value_updated_at, :datetime
  end
end
