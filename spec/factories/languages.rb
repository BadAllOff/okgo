FactoryGirl.define do

  sequence :title do |n|
    "Title for event number #{n}"
  end

  sequence :description do |n|
    "This is the long description for event number #{n}"
  end

  sequence :address do |n|
    "This is the address #{n}"
  end

  factory :event do
    title
    description
    address
    language
    latitude 40.38084568185104
    longitude 49.869089126586914
    max_members 10
    starts_at DateTime.current + 36.hours
    ends_at   DateTime.current + 37.hours
  end

end
