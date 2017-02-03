FactoryGirl.define do
  factory :comment do
    commentable_id 1
    commentable_type "MyString"
    user_id 1
    body "MyText"
  end
end
