require "rails_helper"

RSpec.describe Likes::DestroyService, type: :service do
  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:service) { Likes::DestroyService.new(user, story) }

  describe "#run!" do
    context "when the user does not like the story" do
      it "does not destroy any likes" do
        expect { service.run! }.not_to change(Like, :count)
      end

      it "does not change likes count of the story" do
        expect { service.run! }.not_to change { story.reload.likes_count }
      end
    end

    context "when the user likes the story" do
      before { create(:like, user: user, story: story) }

      it "destroys the like relation between them" do
        service.run!
        expect(Like.where(user: user, story: story)).not_to exist
      end

      it "decrements likes count of the story" do
        expect { service.run! }.to change { story.reload.likes_count }.by(-1)
      end
    end
  end
end
