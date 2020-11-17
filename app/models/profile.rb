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

  def self.guest_profile(user)
    find_or_create_by!(user_id: user.id) do |profile|
      profile.nickname = "ゲスト"
      profile.icon = File.open('./public/uploads/profile/icon/default.png')
      profile.birthday = '1990-05-20'
      profile.gender = 1
      profile.instagram_url = "http://example.com/harland"
      profile.facebook_url = "http://example.com/harland"
      profile.details = "会社員、ゾンビ映画が大好き！"
    end
  end
end
