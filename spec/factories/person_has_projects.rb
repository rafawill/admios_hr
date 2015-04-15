FactoryGirl.define do
  factory :person_has_project do
    person 
    project 
    start_date "2015-03-09"
    finish_date "2015-03-09"
    current_project 1
    note "MyText"
  end
end
