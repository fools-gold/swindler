require "rails_helper"

RSpec.describe Story, type: :model do
  let(:user) { create(:user) }
  let(:story) { create(:story) }

  describe "#liked_by?" do
    context "when passed an user who does not like the story" do
      it "returns false" do
        expect(story.liked_by? user).to be_falsy
      end
    end

    context "when passed an user who likes the story" do
      before { create(:like, user: user, story: story) }

      it "returns true" do
        expect(story.liked_by? user).to be_truthy
      end
    end
  end
end
