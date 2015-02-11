class AddPersonToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :address, :text
    add_column :users, :phone, :string
    add_column :users, :cell_phone, :string
  end
end
