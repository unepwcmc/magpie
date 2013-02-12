class AddInheritanceToResult < ActiveRecord::Migration
  def up
    add_column :results, :value_json, :text
    add_column :results, :type, :string

    Result.reset_column_information

    results = Result.find(:all)

    results.each do |r|
      r.type = 'FloatResult'
      r.save
    end
  end

  def down
    remove_column :results, :value_json
    remove_column :results, :type
  end
end
