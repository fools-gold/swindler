FactoryGirl.define do
  factory :comment do
    user
    story
    text { Faker::Lorem.sentence }
  end
end
