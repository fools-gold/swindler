FactoryGirl.define do
  factory :game do
    title { Faker::App.name }
  end
end
