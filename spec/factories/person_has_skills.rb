FactoryGirl.define do
  factory :person_has_skill do
    person
    association :skill, :factory => [:skill]
    rating 1
    projects 1
    note "MyText"

    trait :language_skill do
      association :skill, :factory => [:skill]
    end

    trait :framework_skill do
      association :skill, :factory => [:skill, :framework]
    end

    trait :data_skill do
      association :skill, :factory => [:skill, :data]
    end

    trait :mobile_skill do
      association :skill, :factory => [:skill, :mobile]
    end


    factory :person_has_language_skill,   traits: [:language_skill] 
    factory :person_has_framework_skill,  traits: [:framework_skill] 
    factory :person_has_data_skill,       traits: [:data_skill] 
    factory :person_has_mobile_skill,     traits: [:mobile_skill] 
  
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
