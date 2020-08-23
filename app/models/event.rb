class Event < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :food_category, presence: true
  validates :restaurant_url, presence: true,
            format: URI::regexp(%w(http https))
  validates :budget, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :check_in_time, presence: true
  enum budget: {
      default: 0,
      till_1000: 1,
      till_2000: 2,
      till_3000: 3,
      till_4000: 4,
      till_5000: 5,
      over_5000: 6,
    },  _prefix: true

  enum check_in_time: {
      default: 0,
      before_1hour: 1,
      before_2hours: 2,
      before_3hours: 3,
      before_24hours: 4,
      before_48hours: 5,
    },  _prefix: true

  enum food_category: {
    italian: 0,
    japanese: 1,
    western: 2,
    chinese: 3,
    other: 4
  }

  enum event_status: {
    pending: 0,
    done: 1
  }

  has_many :apply_for_events, dependent: :destroy
  has_many :apply_for_events_of_user, through: :apply_for_events, source: :user
  has_many :genre_tags, dependent: :destroy
  has_many :genres, through: :genre_tags
  has_many :area_tags, dependent: :destroy
  has_many :areas, through: :area_tags


end
