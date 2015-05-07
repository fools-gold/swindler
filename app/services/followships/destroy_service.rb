module Followships
  class DestroyService
    def initialize(follower, followed)
      @follower = follower
      @followed = followed
    end

    def run!
      @follower.followships.find_by(followed: @followed).destroy if @follower.follows? @followed
    end
  end
end
