class AddDeveloperConditionColumnToPersonHasProject < ActiveRecord::Migration
  def change
    add_column :person_has_projects, :developer_condition, :integer, :default => 0
  end
end
