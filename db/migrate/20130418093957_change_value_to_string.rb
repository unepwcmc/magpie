class ChangeValueToString < ActiveRecord::Migration
  def change
    change_column :results, :value, :text
  end
end
