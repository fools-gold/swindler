FactoryGirl.define do
  factory :story do
    association :by, factory: :user
    association :of, factory: :user
    game
    body { Faker::Lorem.sentence }
  end
end
