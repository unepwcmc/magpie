class RemoveNameFromWorkspaces < ActiveRecord::Migration
  def up
    remove_column :workspaces, :name
  end

  def down
    add_column :workspaces, :name, :string
  end
end
