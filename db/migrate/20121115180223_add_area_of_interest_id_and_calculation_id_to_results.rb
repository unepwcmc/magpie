class AddAreaOfInterestIdAndCalculationIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :area_of_interest_id, :integer
    add_column :results, :calculation_id, :integer
  end
end
