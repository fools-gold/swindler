require "rails_helper"

RSpec.describe Comments::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:story) { create(:story) }
  let(:text) { Faker::Lorem.sentence }
  let(:service) { Comments::CreateService.new(user, story, text) }

  describe "#run!" do
    it "creates the user's comments on the story" do
      service.run!
      expect(Comment.where(user: user, story: story, text: text)).to exist
    end

    it "increments comments count of the story" do
      expect { service.run! }.to change { story.reload.comments_count }.by(1)
    end
  end
end
