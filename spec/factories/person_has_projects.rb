FactoryGirl.define do
  factory :person_has_project do
    person nil
project nil
start_date "2015-03-09"
finish_date "2015-03-09"
current_project false
note "MyText"
  end

end
