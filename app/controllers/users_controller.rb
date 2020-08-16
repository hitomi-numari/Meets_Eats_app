class UsersController < ApplicationController
  before_action :set_user, only: [:show, :my_events]

  def my_events
    render :layout => "_sidebar"
  end

  private

  def set_user
    # binding.pry
    @user = User.find(params[:id])
  end
end
