FactoryGirl.define do

  sequence :name do |n|
    "person#{n}"
  end

  sequence :email do |n|
    "person#{n}@gmail.com"
  end

  factory :person do |u|
    name
    last_name "Smith"
    email 
    home_number "999-9999"
    cel_number "6666-2222"
    address "MyString"
    id_number "8-888-8888"
    document_type_id 13
    birth_day { 25.years.ago }
    country_id 2
  end

end