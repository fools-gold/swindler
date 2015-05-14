class Story < ActiveRecord::Base
  belongs_to :by, class_name: "User", counter_cache: true
  belongs_to :of, class_name: "User", counter_cache: :stories_of_count
  belongs_to :game, counter_cache: true

  validates :body, length: { maximum: 140 }, presence: true
  validates :by, presence: true
  validates :of, presence: true
  validates :game, presence: true

  validate :must_not_make_story_of_oneself

  def must_not_make_story_of_oneself
    errors.add :of, "can't make story of oneself" if by == of
  end
end
