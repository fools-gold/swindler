require "rails_helper"

RSpec.describe Users::FollowingsController, type: :controller do
  let(:user) { create(:user, :with_followings) }
  let(:other_user) { create(:user) }

  describe "GET #index" do
    it "shows user's followings" do
      get :index, user_id: user
      expect(response).to have_http_status(:ok)
      expect(assigns :followings).to eq(user.followings)
    end
  end

  describe "POST #create" do
    context "when user is signed in" do
      before { sign_in user }

      it "requires authorization" do
        post :create, user_id: other_user, id: user
        expect(response).to have_http_status(:unauthorized)
      end

      it "adds the user to current user's followings" do
        post :create, user_id: user, id: other_user
        expect(response).to have_http_status(:ok)
        expect(user.followings).to include(other_user)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        post :create, user_id: user, id: other_user
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE #destroy" do
    before { create(:followship, follower: user, followed: other_user) }

    context "when user is signed in" do
      before { sign_in user }

      it "requires authorization" do
        delete :destroy, user_id: other_user, id: user
        expect(response).to have_http_status(:unauthorized)
      end

      it "removes the user from current user's followings" do
        delete :destroy, user_id: user, id: other_user
        expect(response).to have_http_status(:no_content)
        expect(user.followings).not_to include(other_user)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        delete :destroy, user_id: user, id: other_user
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
