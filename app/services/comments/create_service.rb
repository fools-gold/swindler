module Comments
  class CreateService
    def initialize(user, story, body)
      @user = user
      @story = story
      @body = body
    end

    def run!
      @story.comments.create(user: @user, body: @body)
    end
  end
end
