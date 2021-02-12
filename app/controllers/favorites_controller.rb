class FavoritesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    favorite = current_user.favorites.build(event_id: params[:event_id])
    favorite.save
  end

  def destroy
    @event = Event.find(params[:event_id])
    favorite = Favorite.find(params[:id]).destroy
  end

  def destroy_from_lists
    favorite = Favorite.find(params[:id]).destroy
    redirect_to favorite_lists_user_path(current_user.id)
  end
end
