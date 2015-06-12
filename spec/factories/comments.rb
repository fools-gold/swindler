FactoryGirl.define do
  factory :comment do
    user
    story
    body { Faker::Lorem.sentence }
  end
end
