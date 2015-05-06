class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: [:slugged, :finders]

  include Gravtastic
  has_gravatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :followships, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :followships, source: :followed
  has_many :inverse_followships, foreign_key: "followed_id", class_name: "Followship", dependent: :destroy
  has_many :followers, through: :inverse_followships, source: :follower

  validates :username, presence: true, format: { with: /\A[a-z][a-z0-9.]+\Z/ }
  validates :username, uniqueness: true, case_sensitive: false
  validates :timezone, presence: true, inclusion: { in: ActiveSupport::TimeZone.zones_map(&:name).keys }

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

  def follows?(user)
    followings.include? user
  end

  def followed_by?(user)
    followers.include? user
  end
end
