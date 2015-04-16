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
    nationality "MyString"
  end

end