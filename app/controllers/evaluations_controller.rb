class EvaluationsController < ApplicationController
  before_action :set_event, only: [:rating, :rated]
  before_action :rate_params, only:[:create]

  def create
    if user_signed_in?
      @rate = Evaluation.new(rate_params)
      if params[:back]
        render :new
      else
        if @rate.save
          @event = Event.find(params[:event_id])
          if @rate.organizer_id == @event.user.id
            @event.event_status = "rated"
          else
            @event.event_status = "completed"
          end
          @event.save
          redirect_to rated_evaluation_path(@event)
        else
          render :new
        end
      end
    end
  end

  def rating
    # binding.pry
    @user = ApplyForEvent.find(params[:apply_for_event_id]).user
    @rate = Evaluation.new
  end

  def rated

  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def rate_params
    params.require(:evaluation).permit(:rate, :organizer_id, :paticipant_id)
  end

end
