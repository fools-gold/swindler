require "rails_helper"

RSpec.describe Followships::DestroyService, type: :service do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:service) { Followships::DestroyService.new(user, other_user) }

  describe "#run!" do
    context "when the user is not following other user" do
      it "does not destroy any followships" do
        expect { service.run! }.not_to change(Followship, :count)
      end

      it "does not change followings count of the user" do
        expect { service.run! }.not_to change { user.reload.followings_count }
      end
      it "does not change followers count of other user" do
        expect { service.run! }.not_to change { other_user.reload.followers_count }
      end
    end

    context "when the user is following other user" do
      before { create(:followship, follower: user, followed: other_user) }

      it "destroys the followship between them" do
        service.run!
        expect(Followship.where(follower: user, followed: other_user)).not_to exist
      end

      it "decrements followings count of the user" do
        expect { service.run! }.to change { user.reload.followings_count }.by(-1)
      end

      it "decrements followers count of other user" do
        expect { service.run! }.to change { other_user.reload.followers_count }.by(-1)
      end
    end
  end
end
