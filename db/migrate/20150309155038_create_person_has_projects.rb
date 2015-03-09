class CreatePersonHasProjects < ActiveRecord::Migration
  def change
    create_table :person_has_projects do |t|
      t.references :person, index: true
      t.references :project, index: true
      t.date :start_date
      t.date :finish_date
      t.boolean :current_project
      t.text :note

      t.timestamps
    end
  end
end
