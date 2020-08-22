class UsersController < ApplicationController
  before_action :set_user, only: [:show, :my_events, :event_history]
  layout '_sidebar'
  def my_events
    @events = current_user.events
    @unselected_events = []
    @events.each do |apply|
      if apply.apply_for_events.exists?(status: 'selected')
      else
        @unselected_events << @events.find(apply.id)
      end
    end
  end

  def event_history
    @events = current_user.events
    @unrated_events = []
    @events.each do |apply|
      if apply.apply_for_events.exists?(status: 'selected')
        @unrated_events << @events.find(apply.id)
      else
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
