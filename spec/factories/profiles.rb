# FactoryGirl.define do
#
#   sequence :email do |n|
#     "user#{n}@test.com"
#   end
#
#   sequence :firstname do |n|
#     "firstname#{n}"
#   end
#
#   sequence :lastname do |n|
#     "lastname#{n}"
#   end
#
#   factory :profile do
#     firstname firstname
#     lastname lastname
#     gender 'Male'
#   end
#
#
#   factory :user do
#     email
#     password '123456789'
#     password_confirmation '123456789'
#
#     factory :user_with_profile do
#       # the after(:create) yields two values; the profile instance itself and
#       # the evaluator, which stores all values from the factory, including
#       # ignored attributes; `create_list`'s second argument is the number of
#       # records to create and we make sure the profile is associated properly
#       # to the language
#       after(:create) do |user, evaluator|
#         create(:profile, user: [user])
#       end
#     end
#   end
#
#
# end
