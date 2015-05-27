class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :story, counter_cache: true

  validates :user, presence: true, uniqueness: { scope: :story }
  validates :story, presence: true
end
