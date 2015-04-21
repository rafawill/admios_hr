class RemoveIdTypeFromPeople < ActiveRecord::Migration
  def change
      remove_column :people, :id_type
  end
end
