class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  include Gravtastic
  has_gravatar default: :identicon, size: 100

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :profile_picture, styles: { thumb: "100x100>#", original: "500x500>#" }, default_style: :thumb

  has_many :followships, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :followships, source: :followed
  has_many :inverse_followships, foreign_key: "followed_id", class_name: "Followship", dependent: :destroy
  has_many :followers, through: :inverse_followships, source: :follower

  has_many :stories, foreign_key: "by_id", dependent: :destroy
  has_many :stories_of, foreign_key: "of_id", class_name: "Story", dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :username, presence: true, format: { with: /\A[a-z][a-z0-9.]+\Z/ }
  validates :username, uniqueness: true, case_sensitive: false
  validates :bio, presence: true, allow_blank: true, length: { maximum: 140 }
  validates :timezone, presence: true, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name).keys }

  validates_attachment_size :profile_picture, less_than: 2.megabytes
  validates_attachment_content_type :profile_picture, content_type: %w(image/jpeg image/gif image/png)

  before_validation { self.timezone ||= Rails.application.config.time_zone }

  attr_accessor :login

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      login = conditions.delete(:login).try(:downcase)
      if login.present?
        where(conditions.to_h).where(["lower(username) = :login OR lower(email) = :login", { login: login }]).first
      else
        where(conditions.to_h).first
      end
    end
  end

  def profile_picture_url(style = nil)
    if profile_picture?
      profile_picture.url(style)
    else
      gravatar_url(size: style == :original ? 500 : 100)
    end
  end

  def follows?(user)
    followings.include? user
  end

  def followed_by?(user)
    followers.include? user
  end
end
