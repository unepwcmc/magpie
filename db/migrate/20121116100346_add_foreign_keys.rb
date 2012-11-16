class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key(:areas_of_interest, :workspaces, dependent: :delete)
    add_foreign_key(:polygons, :areas_of_interest, dependent: :delete)
    add_foreign_key(:calculations, :app_layers, dependent: :delete)
    add_foreign_key(:calculations, :operations, dependent: :delete)
    add_foreign_key(:results, :calculations, dependent: :delete)
    add_foreign_key(:results, :areas_of_interest, dependent: :delete)
  end
end
