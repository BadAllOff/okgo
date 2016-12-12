FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyText"
    address "MyString"
    starts_at (DateTime.current + 24.hours)
    ends_at (DateTime.current + 25.hours)
    language
  end
end
