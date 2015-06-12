class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story, counter_cache: true

  validates :user, presence: true
  validates :story, presence: true
  validates :body, length: { maximum: 140 }, presence: true
end
