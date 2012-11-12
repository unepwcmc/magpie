class ChangeAnalysisIdToAreaIdInPolygons < ActiveRecord::Migration
  def up
    rename_column :polygons, :analysis_id, :area_id
  end

  def down
    rename_column :polygons, :area_id, :analysis_id
  end
end
