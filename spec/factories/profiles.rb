FactoryGirl.define do
  factory :profile do
    firstname 'MyString'
    lastname 'MyString'
    gender 'Male'
    credo 'MyText'
    user
  end
end
