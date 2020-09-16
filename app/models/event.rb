class Event < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :apply_for_events, dependent: :destroy
  has_many :apply_for_events_of_user, through: :apply_for_events, source: :user
  has_many :genre_tags, dependent: :destroy
  has_many :genres, through: :genre_tags
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
    イタリアン: 0,
    和食: 1,
    洋食: 2,
    中華: 3,
    その他: 4
  }

  enum event_status: {
    pending: 0,
    done: 1
  }

  def required_time
    if end_at.strftime("%H:%M") < start_at.strftime("%H:%M")
      required_time = ((end_at.strftime("%H:%M").to_i + 24) - start_at.strftime("%H:%M").to_i)
    else
      required_time = (end_at.strftime("%H:%M").to_i - start_at.strftime("%H:%M").to_i)
    end
  end

  def datetime_not_before_start_at
    errors.add(:end_at, "は開始時間以降のものを選択してください") if end_at.nil? || end_at < start_at
  end

  def short_description
    description[0, 9] + '...'
  end

  def self.expired_time
    binding.pry
    case check_in_times
      when 1
        Time.now + 60 * 60
      when 2
        Time.now + 120 * 60
      when 3
        Time.now + 180 * 60
      when 4
        Time.now + 24 * 60 * 60
      when 5
        Time.now + 48 * 60 * 60
      else
        Time.now
    end
  end

  scope :expired, -> { where("start_at >= ?", self.expired_time)}
  scope :pending, -> { where(event_status: "pending") }
  scope :sort_created, -> { order(created_at: :desc) }
  # scope :sort_expired, -> { where("") }

end
