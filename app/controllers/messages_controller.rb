class MessagesController < ApplicationController
  layout '_sidebar'
  before_action do
    @room = Room.find(params[:room_id])
  end
  def index
    @messages = @room.messages
    if @messages.length > 50
      @over_ten = true
      @messages = Message.where(id: @messages[-50..-1].pluck(:id))
    end
    if params[:m]
      @over_ten = false
      @messages = @room.messages
    end
    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end
    @messages = @messages.order(:created_at)
    @message = @room.messages.build
  end

  def create
    @message = @room.messages.build(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      render 'index'
    end
  end
  private
  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
