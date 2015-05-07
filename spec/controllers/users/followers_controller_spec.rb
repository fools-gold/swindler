require "rails_helper"

RSpec.describe Users::FollowersController, type: :controller do
  let(:user) { create(:user, :with_followers) }

  describe "GET #index" do
    it "shows user's followers" do
      get :index, user_id: user
      expect(response).to have_http_status(:ok)
      expect(assigns :followers).to eq(user.followers)
    end
  end
end
