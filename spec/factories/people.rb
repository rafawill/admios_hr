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

    factory :person_with_skills do
      transient do
        skills_counts 1
      end

      after(:create) do |person, evaluator|
        FactoryGirl.create_list(:person_has_skill, evaluator.skills_counts, person: person)
      end
    end

    factory :person_with_language_skill do
      after(:create) do |person, evaluator|
        FactoryGirl.create_list(:person_has_language_skill, 1, person: person)
      end
    end

    factory :person_with_framework_skill do
      after(:create) do |person, evaluator|
        FactoryGirl.create_list(:person_has_framework_skill, 1, person: person)
      end
    end

    factory :person_with_data_skill do
      after(:create) do |person, evaluator|
        FactoryGirl.create_list(:person_has_data_skill, 1, person: person)
      end
    end

    factory :person_with_mobile_skill do
      after(:create) do |person, evaluator|
        FactoryGirl.create_list(:person_has_mobile_skill, 1, person: person)
      end
    end
  end

end