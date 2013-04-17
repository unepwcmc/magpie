class RenameCalcationToStatistic < ActiveRecord::Migration
  def change
    rename_table :calculations, :statistics
  end
end
