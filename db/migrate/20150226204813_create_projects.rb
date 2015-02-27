class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.date :start_date
      t.date :finish_date
      t.string :website
      t.string :github

      t.timestamps
    end
  end
end
