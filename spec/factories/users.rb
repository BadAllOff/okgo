FactoryGirl.define do

  sequence :email do |n|
    "user#{n}@test.com"
  end

  sequence :firstname do |n|
    "firstname#{n}"
  end

  sequence :lastname do |n|
    "lastname#{n}"
  end

  factory :user do
    firstname
    lastname
    gender 'Male'
    email
    password '123456789'
    password_confirmation '123456789'
  end

end
