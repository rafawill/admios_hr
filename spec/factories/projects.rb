FactoryGirl.define do
  factory :project do
    name "MyString"
    description "MyText"
    start_date Date.today
    finish_date 3.month.ago
    website "http://www.example.com"
    github "http://www.github.com"
    client 
  end

end
