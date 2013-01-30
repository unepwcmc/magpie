class AddTableNameToPolygonUpload < ActiveRecord::Migration
  def change
    add_column(:polygon_uploads, :table_name, :string)
  end
end
