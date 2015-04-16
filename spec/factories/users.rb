FactoryGirl.define do
  factory :user do
    name "Test"
    sequence(:email) { |n| "person#{n}@example.com" } 
    password "please123"
    password_confirmation "please123"
    last_name "User"
    phone "999-9999"
    address "panama panama"
    cell_phone "999-9999"
    image_file_name "image.jpg"

    trait :admin do
      role 'admin'
    end

  end
end
