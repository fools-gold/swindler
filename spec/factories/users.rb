FactoryGirl.define do
  factory :user, aliases: %w(follower followed) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.user_name(nil, %w(.)) }
  end
end
