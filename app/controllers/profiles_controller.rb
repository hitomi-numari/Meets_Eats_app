class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_profile, only: [:show, :edit, :update]
  def new
    if user_signed_in? && has_profile?
      @genres = Genre.all
      @areas = Area.all
       redirect_to search_top_events_path
    else
      @profile = Profile.new
      render :new
    end
  end

  def show
    if @profile.id == current_user.id
      render :layout => '_sidebar'
    end
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to profile_path(@profile.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.id), notice: "投稿を更新しました！"
    else
      render :edit
    end
  end

  private

  def set_profile
    # binding.pry
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:nickname, :icon, :birthday, :gender, :instagram_url, :facebook_url, :details)
  end

  def has_profile?
    current_user.profile.present?
  end
end
