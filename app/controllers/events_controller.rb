class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :apply_members]

  def index
    binding.pry
    @genre = Genre.find(params[:genre_id])
    # @search = Event.ransack(params[:q])
    # @profiles = Profile.all
    # @events = @search.result.includes(:user).page(params[:page])
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

  def search_top
    @genres = Genre.all
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :content, :restaurant_url, :budget, :start_at, :end_at, :check_in_time, :food_category, { area_ids: []}, { genre_ids: [] })
  end

end
