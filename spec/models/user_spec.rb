require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

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
end
