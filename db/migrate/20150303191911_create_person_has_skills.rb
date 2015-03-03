class CreatePersonHasSkills < ActiveRecord::Migration
  def change
    create_table :person_has_skills do |t|
      t.references :person, index: true
      t.references :skill, index: true
      t.integer :rating
      t.integer :projects
      t.text :note

      t.timestamps
    end
  end
end
