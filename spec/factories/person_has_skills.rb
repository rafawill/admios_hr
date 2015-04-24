FactoryGirl.define do
  factory :person_has_skill do
    person
    skill
    rating 1
    projects 1
    note "MyText"
  
    end 
  
    trait :skill do
      after(:create) do |person_has_skill|
        person_has_skill.skill = create(:skill)
      end
    end

    trait :person do
      after(:create) do |person_has_skill|
        person_has_skill.person = create(:person)
      end
    end
  
end
