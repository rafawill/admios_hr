class CreateProjectHasSkills < ActiveRecord::Migration
  def change
    create_table :project_has_skills do |t|
      t.references :project, index: true
      t.references :skill, index: true
      t.text :note

      t.timestamps
    end
  end
end
