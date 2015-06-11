class UsersController < ApplicationController
  before_action :set_user, only: [:show, :stories, :stories_of]
  before_action :authenticate_user!, only: [:show, :stories, :stories_of]

  def show
    @stories = Story.related_to(@user).recent.page(params[:page])
  end

  def stories
    @stories = @user.stories.recent.page(params[:page])
  end

  def stories_of
    @stories = @user.stories_of.recent.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
