class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, format: { with: /\A[a-z][a-z0-9.]+\Z/ }
  validates :username, uniqueness: true, case_sensitive: false

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
end
