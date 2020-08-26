class UsersController < ApplicationController
  before_action :set_user, only: [:show, :my_events, :event_history]
  layout '_sidebar'
  def my_events
    @events = current_user.events.where(event_status: "pending")
  end

  def event_history
    @events = current_user.events.where(event_status: "done")
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
