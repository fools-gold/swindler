module Likes
  class DestroyService
    def initialize(user, story)
      @user = user
      @story = story
    end

    def run!
      @user.likes.find_by(story: @story).destroy if @user.likes? @story
    end
  end
end
