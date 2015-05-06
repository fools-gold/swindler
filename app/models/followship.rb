class Followship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower, presence: true, uniqueness: { scope: :followed }
  validates :followed, presence: true, uniqueness: { scope: :follower }
end
