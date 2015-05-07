require "rails_helper"

RSpec.describe Users::FollowingsController, type: :controller do
  let(:user) { create(:user, :with_followings) }

  describe "GET #index" do
    it "shows user's followings" do
      get :index, user_id: user
      expect(response).to have_http_status(:ok)
      expect(assigns :followings).to eq(user.followings)
    end
  end
end
