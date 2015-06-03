require "rails_helper"

RSpec.describe Users::LikesController, type: :controller do
  let(:user) { create(:user, :with_likes) }
  let(:other_user) { create(:user) }
  let(:story) { create(:story) }

  describe "GET #index" do
    it "shows user's liked stories" do
      get :index, user_id: user
      expect(response).to have_http_status(:ok)
      expect(assigns :liked_stories).to eq(user.liked_stories)
    end
  end

  describe "POST #create" do
    context "when the user is signed in" do
      before { sign_in user }

      it "requires authorization" do
        post :create, user_id: other_user, id: story
        expect(response).to have_http_status(:unauthorized)
      end

      it "adds the story to the user's liked stories" do
        post :create, user_id: user, id: story
        expect(user.liked_stories).to include(story)
      end
    end

    context "when the user is not signed in" do
      it "redirects to sign in page" do
        post :create, user_id: user, id: story
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    before { create(:like, user: user, story: story) }

    context "when user is signed in" do
      before { sign_in user }

      it "requires authorization" do
        delete :destroy, user_id: other_user, id: story
        expect(response).to have_http_status(:unauthorized)
      end

      it "removes the story from current user's liked stories" do
        delete :destroy, user_id: user, id: story
        expect(user.liked_stories).not_to include(story)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        delete :destroy, user_id: user, id: story
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
