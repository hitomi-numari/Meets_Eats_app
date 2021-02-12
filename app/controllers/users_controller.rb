class UsersController < ApplicationController
  before_action :ensure_correct_user
  before_action :set_user, only: [:show, :my_events, :event_history]
  layout '_sidebar'

  def my_event
    @events = current_user.events.pending
  end

  def event_history
    @unrated_events = current_user.events.unrated.sort_created
    @rated_events = current_user.events.rated.sort_created
  end

  def joined_event_history
    @unrated_events = current_user.apply_for_events_of_event.unrated.sort_created
    @rated_events = current_user.apply_for_events_of_event.rated.sort_created
  end

  def favorite_lists
    @events = current_user.favorite_users.sort_created
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if current_user.id != @user.id
      flash[:danger] = "権限がありません"
      redirect_to search_top_events_path
    end
  end

end
