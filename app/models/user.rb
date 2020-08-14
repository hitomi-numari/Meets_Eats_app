class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events
  has_many :apply_for_events, dependent: :destroy
  has_one :profile
  accepts_nested_attributes_for :profile
end
