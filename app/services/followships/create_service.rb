module Followships
  class CreateService
    def initialize(follower, followed)
      @follower = follower
      @followed = followed
    end

    def run!
      @follower.followships.create(followed: @followed) unless @follower.follows? @followed
    end
  end
end
