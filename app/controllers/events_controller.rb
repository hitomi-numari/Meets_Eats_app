class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :apply_members, :prohibit_selected]
  before_action :ensure_correct_post, only: [:edit, :update, :destroy]

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @q = @genre.genre_tag_events.pending.sort_created.ransack(params[:q])
      #性別・年代の絞り込み　さらに＠qで絞り込む
      @events = @q.result(distinct: true).page(params[:page]).per(20)
    elsif params[:area_id]
      @area = Area.find(params[:area_id])
      @q = @area.events.pending.sort_created.ransack(params[:q])
      @events = @q.result(distinct: true).includes(:genre_tags, :genres).page(params[:page]).per(20)
    else
      if params[:sort_created]
        @q = Event.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres).page(params[:page]).per(20)
      elsif params[:sort_expired]
        @q = Event.expired.pending.sort_expired.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres).page(params[:page]).per(20)
      else
        @q = Event.expired.pending.sort_created.ransack(params[:q])
        @events = @q.result(distinct: true).includes(:genre_tags, :genres).page(params[:page]).per(20)
      end
    end
    #@eventsに対して年齢指定があれば、該当しない結果を取り除く。
  end

  def show
    # binding.pry
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
    elsif params[:area_name]
      @area = Area.find(params[:area_id])
    end
    @apply = current_user.apply_for_events.find_by(event_id: @event.id)
  end

  def new
    # binding.pry
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
    elsif params[:area_id]
      @area = Area.find(params[:area_id])
    end

    @event = Event.new
  end

  def edit
  end

  def create
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
    # @picture = Picture.find_by(id: params[:id])
    if current_user.id != @event.user_id
      flash[:danger] = "権限がありません"
      redirect_to action: "index"
    end
  end

end
