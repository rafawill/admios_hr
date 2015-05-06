class AddSkypeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :skype, :string
  end
end
