FactoryGirl.define do

  sequence :name do |n|
    "person#{n}"
  end

  sequence :email do |n|
    "person#{n}@gmail.com"
  end

  factory :person do
    name
    last_name "MyString"
    email 
    home_number "MyString"
    cel_number "MyString"
    address "MyString"
    id_type 0
    id_number "MyString"
    birth_day "2015-02-26"
    #association :person_has_skills, factory: :skill, strategy: :build
    #association :person_has_projects, factory: :person_has_projects, strategy: :build
    #association :skill, factory: :skill, strategy: :build
  end

end