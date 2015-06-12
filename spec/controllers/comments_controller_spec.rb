require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:body) { Faker::Lorem.sentence }
  let(:story) { create(:story) }
  let(:other_user) { create(:user) }

  describe "POST #create" do
    context "when the user is signed in" do
      before { sign_in user }

      it "adds the comment to the story" do
        post :create, story_id: story, body: body
        expect(Comment.where(user: user, story: story, body: body)).to exist
      end
    end

    context "when the user is not signed in" do
      it "redirects to sign in page" do
        post :create, story_id: story, body: body
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) { create(:comment, user: user, story: story) }

    context "when the other user is signed in" do
      before { sign_in other_user }

      it "requires authorization" do
        delete :destroy, story_id: story, id: comment
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when the user is signed in" do
      before { sign_in user }

      it "removes the comment from the story" do
        delete :destroy, story_id: story, id: comment
        expect(story.commenters).not_to include(user)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        delete :destroy, story_id: story, id: comment
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
