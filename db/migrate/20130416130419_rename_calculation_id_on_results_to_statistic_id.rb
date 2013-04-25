class RenameCalculationIdOnResultsToStatisticId < ActiveRecord::Migration
  def change
    rename_column :results, :calculation_id, :statistic_id
  end
end
