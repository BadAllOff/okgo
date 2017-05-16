FactoryGirl.define do

  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password '123456789'
    password_confirmation '123456789'
    confirmed_at          Time.now

    factory :admin_user do
      role 2
    end
  end

end
