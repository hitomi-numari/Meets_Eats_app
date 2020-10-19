class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    message = Message.new(content: data["content"], room_id: data["room_id"], user_id: current_user.id)
    message.save
    ActionCable.server.broadcast "room_channel", content: data["content"], room_id: data["room_id"]
  end
end
