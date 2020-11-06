class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates_presence_of :content, :room_id, :user_id
  def message_time
    created_at.strftime("%H:%M")
  end
end
