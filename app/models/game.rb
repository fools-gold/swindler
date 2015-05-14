class Game < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_many :stories, dependent: :destroy

  validates :title, presence: true
end
