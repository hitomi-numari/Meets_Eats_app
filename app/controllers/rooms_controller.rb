class RoomsController < ApplicationController
  layout '_sidebar'
  def index
    @rooms = Room.all
  end
  def create
    if user_signed_in?
      if Room.between(params[:sender_id], params[:recipient_id]).present?
        @room = Room.between(params[:sender_id], params[:recipient_id]).first
      else
        @room = Room.create!(room_params)
      end
      redirect_to room_messages_path(@room)
    else
      redirect_to root_path
    end
  end
  private
  def room_params
    params.permit(:sender_id, :recipient_id)
  end
end
