class Story < ActiveRecord::Base
  belongs_to :by, class_name: "User", counter_cache: true
  belongs_to :of, class_name: "User", counter_cache: :stories_of_count
  belongs_to :game, counter_cache: true

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :photo,
    styles: { original: "1280x1280>", medium: "640x640>", thumb: "100x100>" },
    default_style: :medium

  validates :body, length: { maximum: 140 }, presence: true
  validates :by, presence: true
  validates :of, presence: true
  validates :game, presence: true

  validates_attachment_content_type :photo, content_type: %w(image/jpeg image/gif image/png)
  validates_attachment_size :photo, less_than: 3.megabytes

  validate :must_not_make_story_of_oneself

  def must_not_make_story_of_oneself
    errors.add :of, "can't make story of oneself" if by == of
  end

  def liked_by?(user)
    likers.include? user
  end
end
