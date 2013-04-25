class AddErrorStackAndErrorMessageToResults < ActiveRecord::Migration
  def change
    add_column :results, :error_message, :string
    add_column :results, :error_stack, :text
  end
end
