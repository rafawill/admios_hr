FactoryGirl.define do
  factory :skill do
    name "Haskell"
    skill_type "Languages"
	origin "Open Source"
	description "MyString"
	documentation "MyString"
	release_date "2015-03-02"
	current_version "MyString"

	trait :framework do
      skill_type "Frameworks"
    end

    trait :data do
      skill_type "Data"
    end

    trait :mobile do
      skill_type "Mobile"
    end
  end
end
