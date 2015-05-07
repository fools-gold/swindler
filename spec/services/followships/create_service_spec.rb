require "rails_helper"

RSpec.describe Followships::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:service) { Followships::CreateService.new(user, other_user) }

  describe "#run!" do
    context "when the user is not following other user" do
      it "creates a followship between them" do
        service.run!
        expect(Followship.where(follower: user, followed: other_user)).to exist
      end

      it "increments followings count of the user" do
        expect { service.run! }.to change { user.reload.followings_count }.by(1)
      end

      it "increments followers count of other user" do
        expect { service.run! }.to change { other_user.reload.followers_count }.by(1)
      end
    end

    context "when the user is following other user" do
      before { create(:followship, follower: user, followed: other_user) }

      it "does not create any followships" do
        expect { service.run! }.not_to change(Followship, :count)
      end

      it "does not change followings count of the user" do
        expect { service.run! }.not_to change { user.reload.followings_count }
      end

      it "does not change followers count of other user" do
        expect { service.run! }.not_to change { other_user.reload.followers_count }
      end
    end

    context "when both users are the same" do
      let(:service) { Followships::CreateService.new(user, user) }

      it "does not create any followships" do
        expect { service.run! }.not_to change(Followship, :count)
      end

      it "does not change followings count of the user" do
        expect { service.run! }.not_to change { user.reload.followings_count }
      end

      it "does not change followers count of the user" do
        expect { service.run! }.not_to change { user.reload.followers_count }
      end
    end
  end
end
