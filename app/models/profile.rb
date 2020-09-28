class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :icon, IconUploader
  validates :icon, presence: true
  validates :nickname, presence: true, length: { maximum: 30 }
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :details, presence: true
  validates :facebook_url, format: URI::regexp(%w(http https)), if: -> { facebook_url.presence }
  validates :instagram_url, format: URI::regexp(%w(http https)), if: -> { instagram_url.presence }

  def calc_age
    age = (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10000
  end

end
