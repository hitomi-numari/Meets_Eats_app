class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :apply_for_events, dependent: :destroy
  has_one :profile
  has_many :messages, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest1@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.guest2
    find_or_create_by!(email: 'guest2@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
