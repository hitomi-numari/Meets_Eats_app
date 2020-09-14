class GenreTag < ApplicationRecord
  belongs_to :genre
  belongs_to :event
  validates :genre_id, uniqueness: { scope: [:event_id] }
end
