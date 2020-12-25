# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new_guest1
    user = User.guest
    Profile.guest_profile(user)
    sign_in user
    redirect_to search_top_events_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  def new_guest2
    user = User.guest2
    Profile.guest_profile2(user)
    sign_in user
    redirect_to search_top_events_path, notice: 'ゲストユーザーとしてログインしました。'
  end

    # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
