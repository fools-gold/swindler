require "rails_helper"

RSpec.describe Likes::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:service) { Likes::CreateService.new(user, story) }

  describe "#run!" do
    context "when the user does not like the story" do
      it "creates a like between them" do
        service.run!
        expect(Like.where(user: user, story: story)).to exist
      end

      it "increments likes count of the story" do
        expect { service.run! }.to change { story.reload.likes_count }.by(1)
      end
    end

    context "when the user likes the story" do
      before { create(:like, user: user, story: story) }

      it "does not create any likes" do
        expect { service.run! }.not_to change(Like, :count)
      end

      it "does not change likes count of the story" do
        expect { service.run! }.not_to change { story.reload.likes_count }
      end
    end
  end
end
