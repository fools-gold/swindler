module Users
  class FollowingsController < ApplicationController
    before_action :set_user
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :authorize!, only: [:create, :destroy]

    def index
      @followings = @user.followings
    end

    def create
      Followships::CreateService.new(@user, User.find(params[:id])).run!
      head :ok
    end

    def destroy
      Followships::DestroyService.new(@user, User.find(params[:id])).run!
      head :no_content
    end

    private

    def set_user
      @user = User.find(params[:user_id])
    end

    def authorize!
      head :unauthorized unless current_user == @user
    end
  end
end
