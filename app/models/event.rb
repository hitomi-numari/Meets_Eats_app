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
  validate :end_check

  enum budget: {
    till_1000: 0,
    till_2000: 1,
    till_3000: 2,
    till_4000: 3,
    till_5000: 4,
    over_5000: 5,
  },  _prefix: true

  enum check_in_time: {
    before_1hour: 0,
    before_2hours: 1,
    before_3hours: 2,
    before_24hours: 3,
    before_48hours: 4,
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

  def end_check
    errors.add(:end_at, "開始時間より1時間以上後の設定にしてください。") unless
    self.end_at >= self.start_at + 60 * 60
  end

  def required_time
    if end_at.strftime("%H:%M") < start_at.strftime("%H:%M")
      required_time = ((end_at.strftime("%H:%M").to_i + 24) - start_at.strftime("%H:%M").to_i)
    else
      required_time = (end_at.strftime("%H:%M").to_i - start_at.strftime("%H:%M").to_i)
    end
  end

  def short_description
    description[0, 9] + '...'
  end

  def calc_expired_time(check_in_time, start_at)
    case check_in_time
      when "before_1hour"
        start_at - 60 * 60
      when "before_2hours"
        start_at - 120 * 60
      when "before_3hours"
        start_at - 180 * 60
      when "before_24hours"
        start_at - 24 * 60 * 60
      when "before_48hours"
        start_at - 48 * 60 * 60
    end
  end

  scope :expired, -> { where("expired_time >= ?", Time.now)}
  scope :pending, -> { where(event_status: "pending") }
  scope :sort_created, -> { order(created_at: :desc) }
  scope :sort_expired, -> { order(expired_time: :asc) }

  paginates_per 15
end
