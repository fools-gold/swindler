module Comments
  class DestroyService
    def initialize(user, comment)
      @user = user
      @comment = comment
    end

    def run!
      @comment.destroy if @user.commented? @comment
    end
  end
end
