class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :apply_members, :prohibit_selected]
  before_action :ensure_correct_post, only: [:edit, :update, :destroy]
  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      if params[:sort_created]
        @q = @genre.genre_tag_events.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true)
      elsif params[:sort_expired]
        @q = @genre.genre_tag_events.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true)
      else
        @q = @genre.genre_tag_events.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true)
      end
    elsif params[:area_id]
      @area = Area.find(params[:area_id])
      if params[:sort_created]
        @q = @area.events.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres)
      elsif params[:sort_expired]
        @q = @area.events.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres)
      else
        @q = @area.events.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres)
      end
    else
      if params[:sort_created]
        @q = Event.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres)
      elsif params[:sort_expired]
        @q = Event.expired.pending.sort_expired.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres)
      else
        @q = Event.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres)
      end
    end
    @events = @events.page(params[:page])
  end

  def show
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
    elsif params[:area_name]
      @area = Area.find(params[:area_id])
    end
    @apply = current_user.apply_for_events.find_by(event_id: @event.id)
  end

  def new
    if params[:info]
      @restaurant_info = params[:info]
    elsif params[:area_id]
      @area = Area.find(params[:area_id])
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
    end

    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    @event.expired_time = @event.calc_expired_time(@event.check_in_time, @event.start_at)
    @event.save
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
      @event.expired_time = @event.calc_expired_time(@event.check_in_time, @event.start_at)
      @event.save
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
    @areas = Area.all
  end

  def complete
    @apply = ApplyForEvent.find(params[:id])
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :content, :restaurant_url, :budget, :start_at, :end_at,
                                  :check_in_time, :food_category, :area_id, { genre_ids: [] })
  end

  def ensure_correct_post
    if current_user.id != @event.user_id
      flash[:danger] = "権限がありません"
      redirect_to action: "index"
    end
  end

end
