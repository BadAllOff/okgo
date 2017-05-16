FactoryGirl.define do
  sequence :feedback_description do |n|
    "This is the long description for FEEDBACK number #{n}"
  end

  factory :feedback do
    user
    feedback "This is the long description for FEEDBACK number"
  end

end