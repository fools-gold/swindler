class Followship < ActiveRecord::Base
  belongs_to :follower, class_name: "User", counter_cache: :followings_count
  belongs_to :followed, class_name: "User", counter_cache: :followers_count

  validates :follower, presence: true, uniqueness: { scope: :followed }
  validates :followed, presence: true, uniqueness: { scope: :follower }

  validate :must_not_follow_oneself

  private

  def must_not_follow_oneself
    errors.add :follower, "can't follow oneself" if follower == followed
  end
end
