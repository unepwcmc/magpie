class RenameAreaIdToAreaOfInterestIdInPolygons < ActiveRecord::Migration
  def up
    rename_column :polygons, :area_id, :area_of_interest_id
  end

  def down
    rename_column :polygons, :area_of_interest_id, :area_id
  end
end
