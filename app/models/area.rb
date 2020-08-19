class Area < ApplicationRecord
  has_many :area_tags, dependent: :destroy
  has_many :events, through: :area_tags
end
