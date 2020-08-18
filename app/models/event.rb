class Event < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true
  # validates :genre, presence: true
  validates :restaurant_url, presence: true
  # validates :budget, presence: true
  # validates :area, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  # validates :check_in_time, presence: true

  # enum genre: {other:0, italian:1, japanese:2, western:3, chinese:4}

  has_many :apply_for_events, dependent: :destroy
  has_many :apply_for_events_of_user, through: :apply_for_events, source: :user
  has_many :genre_tags, dependent: :destroy
  has_many :genres, through: :genre_tags
end
