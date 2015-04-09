require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #show" do
    it "shows the user" do
      get :show, id: user
      expect(response).to have_http_status(:ok)
      expect(assigns :user).to eq(user)
    end
  end
end
