class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :finish_date
      t.string :website
      t.string :github
      t.references :client, index: true

      t.timestamps
    end
  end
end
