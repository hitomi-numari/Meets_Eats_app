class Evaluation < ApplicationRecord
  belongs_to :organizer, class_name: "User"
  belongs_to :paticipant, class_name: "User"
  validates :organizer_id, presence: true
  validates :paticipant_id, presence: true
  validates :rate, presence: true

  enum rate: {
    good: 0,
    bad: 1,
  }

  # def evaluate!(other_user)
  #   paticipant_evaluations.create!(organizer_id: other_user.id)
  # end
  #
  # def evaluated?(other_user)
  #   paticipant_evaluations.find_by(organizer_id: other_user.id)
  # end

end
