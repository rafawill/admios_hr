class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :skill_type
      t.string :origin
      t.text :description
      t.string :documentation
      t.date :release_date
      t.string :current_version

      t.timestamps
    end
  end
end
