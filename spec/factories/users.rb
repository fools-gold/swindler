FactoryGirl.define do
  factory :user, aliases: %w(follower followed) do
    transient do
      followings_count 3
      followers_count 3
    end

    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.user_name(nil, %w(.)) }
    bio { Faker::Lorem.sentence }

    trait :with_followings do
      after(:create) do |user, evaluator|
        create_list(:followship, evaluator.followings_count, follower: user)
      end
    end

    trait :with_followers do
      after(:create) do |user, evaluator|
        create_list(:followship, evaluator.followers_count, followed: user)
      end
    end
  end
end
