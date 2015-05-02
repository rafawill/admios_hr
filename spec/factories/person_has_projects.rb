FactoryGirl.define do
  factory :person_has_project do
    person 
    project 
    start_date "2015-03-09"
    finish_date "2015-03-09"
    note "MyText"

    trait :current_project_true do
      current_project true
    end

    trait :current_project_false do
      current_project false
    end
  

   factory :person_has_project_true,   traits: [:current_project_true] 
   factory :person_has_project_false,   traits: [:current_project_false]
   end
end
