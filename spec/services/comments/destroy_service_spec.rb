require "rails_helper"

RSpec.describe Comments::DestroyService, type: :service do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:story) { create(:story) }
  let(:body) { Faker::Lorem.sentence }
  let!(:comment) { create(:comment, user: user, story: story, body: body) }

  describe "#run!" do
    context "when the user does not commented the comment" do
      let(:service) { Comments::DestroyService.new(other_user, comment) }

      it "does not destroy any comments" do
        expect { service.run! }.not_to change(Comment, :count)
      end

      it "does not change comments count of the story" do
        expect { service.run! }.not_to change { story.reload.comments_count }
      end
    end

    context "when the user commented the comment" do
      let(:service) { Comments::DestroyService.new(user, comment) }

      it "destroys the comment" do
        service.run!
        expect(Comment.where(user: user, story: story, body: body)).not_to exist
      end

      it "decrements comments count of the story" do
        expect { service.run! }.to change { story.reload.comments_count }.by(-1)
      end
    end
  end
end
