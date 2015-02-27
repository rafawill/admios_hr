class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :home_number
      t.string :cel_number
      t.string :address
      t.string :id_type
      t.string :id_number
      t.date :birth_day

      t.timestamps
    end
  end
end
