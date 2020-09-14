class ApplyForEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :event_id, uniqueness: { scope: :user_id }
  accepts_nested_attributes_for :event, allow_destroy: true
  enum status:{ unselected:0, selected:1}

  def toggle_status!(status)
    if unselected?
      selected!
    else
      unselected!
    end
  end
end
