class Genre < ApplicationRecord
  has_many :genre_tags, dependent: :destroy
  has_many :events, through: :genre_tags
  has_many :genre_tag_events, through: :genre_tags, source: :event
end
