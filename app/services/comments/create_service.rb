module Comments
  class CreateService
    def initialize(user, story, text)
      @user = user
      @story = story
      @text = text
    end

    def run!
      @story.comments.create(text: @text, user: @user)
    end
  end
end
