module Users
  class LikesController < ApplicationController
    before_action :set_user
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :authorize!, only: [:create, :destroy]

    def index
      @liked_stories = @user.liked_stories
    end

    def create
      Likes::CreateService.new(@user, Story.find(params[:id])).run!
      head :ok
    end

    def destroy
      Likes::DestroyService.new(@user, Story.find(params[:id])).run!
      head :no_content
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def authorize!
      head :forbidden unless current_user == @user
    end
  end
end
