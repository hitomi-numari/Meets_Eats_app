class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :apply_members, :prohibit_selected]
  before_action :prohibit_selected, only: [:apply_members]

  def index
    @q = Event.where(event_status: "pending").ransack(params[:q])
    # @events = @q.result(distinct: true).page(params[:page]).per(20)
    @events = @q.result.joins(user: :profile)
  end

  def show
    @apply = current_user.apply_for_events.find_by(event_id: @event.id)
  end

  def new
    if params[:back]
      @event = Event.new(event_params)
    else
      @event = Event.new
    end
  end

  def edit
  end

  def create
    area_ids = params[:event][:area_ids]
    params[:event][:area_ids] = [area_ids]
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @event.save
        redirect_to events_path
      else
        render :new
      end
    end
  end

  def update
    if @event.update(event_params)
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def apply_members
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :content, :restaurant_url, :budget, :start_at, :end_at,
                                  :check_in_time, :food_category, { area_ids: []}, { genre_ids: [] })
  end

  def prohibit_selected
    if @event.apply_for_events.exists?(status: 'selected')
      redirect_to my_events_user_path(current_user.id)
    end
  end

end
