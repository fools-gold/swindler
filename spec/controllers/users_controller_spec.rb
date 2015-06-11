require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, :with_stories, :with_stories_of) }

  before { sign_in user }

  describe "GET #show" do
    it "shows the user" do
      get :show, user_id: user
      expect(assigns :user).to eq(user)
    end

    it "shows stories by and of the user in descending order of created_at" do
      get :show, user_id: user
      expect(assigns :stories).to eq(Story.related_to(user).recent.page)
    end
  end

  describe "GET #stories" do
    it "shows the user" do
      get :stories, user_id: user
      expect(assigns :user).to eq(user)
    end

    it "shows stories by the user in descending order of created_at" do
      get :stories, user_id: user
      expect(assigns :stories).to eq(user.stories.recent.page)
    end
  end

  describe "GET #stories_of" do
    it "shows the user" do
      get :stories_of, user_id: user
      expect(assigns :user).to eq(user)
    end

    it "shows stories of the user in descending order of created_at" do
      get :stories_of, user_id: user
      expect(assigns :stories).to eq(user.stories_of.recent.page)
    end
  end
end
