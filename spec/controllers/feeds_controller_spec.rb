require "rails_helper"

RSpec.describe FeedsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #show" do
    context "when user is signed in" do
      before { sign_in user }

      it "renders an empty page" do
        get :show
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
