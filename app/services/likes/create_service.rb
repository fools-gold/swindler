module Likes
  class CreateService
    def initialize(user, story)
      @user = user
      @story = story
    end

    def run!
      @user.likes.create(story: @story) unless @user.likes? @story
    end
  end
end
