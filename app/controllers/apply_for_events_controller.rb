class ApplyForEventsController < ApplicationController
  before_action :prohibit_selected, only:[:toggle_status]
  before_action :prohibit_organizer, only:[:create]
  before_action :set_apply, only:[:toggle_status, :cancel_mail, :cancel]

  def create
    apply = current_user.apply_for_events.create(event_id: params[:event_id])
    redirect_to events_path, notice: "#{apply.event.user.profile.nickname}さんのイベントに応募しました"
  end
  def destroy
    apply = current_user.apply_for_events.find_by(id: params[:id]).destroy
    redirect_to events_path, notice: "#{apply.event.user.profile.nickname}さんのイベントをキャンセルしました"
  end

  def toggle_status
    @apply.toggle_status!(status: @apply.status)
    @event_status = Event.find(@apply.event.id)
    @event_status.event_status = "done"
    @event_status.save
    @matching_info = @apply
    MatchingMailer.matching_mail(@matching_info).deliver
    @unmatching_info = @apply.event.apply_for_events.where.not(id: @apply.id)
    @unmatching_info.each do |unmatching_info|
      UnmatchingMailer.unmatching_mail(unmatching_info).deliver
    end
    @unmatching_info.destroy_all
    redirect_to complete_event_path(id: @apply.id)
  end

  def cancel_mail
    @cancel_info = @apply
    CancelMailer.cancel_mail(@cancel_info).deliver
    event = Event.find(params[:id])
    event.event_status = "cancelling"
    event.save
    redirect_to cancel_apply_for_event_path(apply_for_event_id: @apply.id)
  end

  def cancel
  end

  def cancel_status
    event = Event.find(params[:id])
    applies = event.apply_for_events.destroy_all
    event.event_status = "pending"
    event.save
    redirect_to cancel_complete_apply_for_events_path
  end

  private

  def set_apply
    @apply = ApplyForEvent.find(params[:apply_for_event_id])
  end

  def prohibit_selected
    apply = ApplyForEvent.find(params[:apply_for_event_id])
    if apply.status == 'selected'
      redirect_to my_event_user_path(current_user.id)
    end
  end

  def prohibit_organizer
    event = Event.find(params[:event_id])
    if current_user.id == event.user.id
      flash[:danger] = "このイベントには参加できません"
      redirect_back fallback_location: event.id
    end
  end
end
