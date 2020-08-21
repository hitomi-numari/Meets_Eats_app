class ApplyForEventsController < ApplicationController
  def create
    apply = current_user.apply_for_events.create(event_id: params[:event_id])
    redirect_to events_path, notice: "#{apply.event.user.profile.nickname}さんのブログをお気に入り登録しました"
  end
  def destroy
    apply = current_user.apply_for_events.find_by(id: params[:id]).destroy
    redirect_to events_path, notice: "#{apply.event.user.profile.nickname}さんのブログをお気に入り解除しました"
  end

  def toggle_status
    apply = ApplyForEvent.find(params[:apply_for_event_id])
    apply.toggle_status!(status: apply.status)
    @matching_info = apply
    MatchingMailer.matching_mail(@matching_info).deliver
    @unmatching_info = ApplyForEvent.where.not(id: apply.id)
    @unmatching_info.each do |unmatching_info|
    UnmatchingMailer.unmatching_mail(unmatching_info).deliver
    end
    render complete_events_path
  end
end
