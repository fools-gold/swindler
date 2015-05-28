require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:story) { create(:story) }

  describe "#profile_picture_url" do
    context "when the user has uploaded a profile picture" do
      let(:user) { create(:user, :with_profile_picture) }

      it "returns URL to that uploaded picture" do
        expect(user.profile_picture_url).to eq(user.profile_picture.url)
      end
    end

    context "when the user has not uploaded a profile picture" do
      it "returns URL to the user's gravatar" do
        expect(user.profile_picture_url).to eq(user.gravatar_url)
      end
    end
  end

  describe "#follows?" do
    context "when passed another user that the user does not follow" do
      it "returns false" do
        expect(user.follows? other_user).to be_falsy
      end
    end

    context "when passed another user that the user follows" do
      before { create(:followship, follower: user, followed: other_user) }

      it "returns true" do
        expect(user.follows? other_user).to be_truthy
      end
    end
  end

  describe "#followed_by?" do
    context "when passed another user who does not follow the user" do
      it "returns false" do
        expect(user.followed_by? other_user).to be_falsy
      end
    end

    context "when passed another user who follows the user" do
      before { create(:followship, follower: other_user, followed: user) }

      it "returns true" do
        expect(user.followed_by? other_user).to be_truthy
      end
    end
  end

  describe "#likes?" do
    context "when passed a story which is not liked by the user" do
      it "returns false" do
        expect(user.likes? story).to be_falsy
      end
    end

    context "when passed a story which is liked by the user" do
      before { create(:like, user: user, story: story) }

      it "returns true" do
        expect(user.likes? story).to be_truthy
      end
    end
  end
end
