FactoryGirl.define do
  factory :user, aliases: %w(follower followed) do
    transient do
      followings_count 3
      followers_count 3
      liked_stories_count 3
      stories_count 3
      stories_of_count 3
    end

    email { Faker::Internet.email }
    password { Faker::Internet.password }
    username { Faker::Internet.user_name(nil, %w(.)) }
    bio { Faker::Lorem.sentence }

    trait :with_profile_picture do
      profile_picture_file_name { "test.png" }
      profile_picture_content_type { "image/png" }
      profile_picture_file_size { 1024 }
    end

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

    trait :with_likes do
      after(:create) do |user, evaluator|
        create_list(:like, evaluator.liked_stories_count, user: user)
      end
    end

    trait :with_stories do
      after(:create) do |user, evaluator|
        create_list(:story, evaluator.stories_count, by: user)
      end
    end

    trait :with_stories_of do
      after(:create) do |user, evaluator|
        create_list(:story, evaluator.stories_of_count, of: user)
      end
    end
  end
end
