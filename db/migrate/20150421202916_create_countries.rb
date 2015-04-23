class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name

      t.timestamps
    end

    change_table :people do |t|
        t.references :country
    end

    Country.create :name => 'Argentina'
    Country.create :name => 'Brasil'
    Country.create :name => 'Bolivia'
    Country.create :name => 'Colombia'
    Country.create :name => 'Honduras'
    Country.create :name => 'Panama'
    Country.create :name => 'Venezuela'

    Person.find_each do |person|
        person.country = Country.where({:name=>person.nationality}).first
        person.save!
    end

    remove_column :people, :nationality



  end
end
