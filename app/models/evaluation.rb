class Evaluation < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  belongs_to :paticipant, class_name: "User"
  validates :organizer_id, presence: true
  validates :paticipant_id, presence: true

  enum rate: {
    unrated: 0,
    good: 1,
    bad: 2,
  }
end
