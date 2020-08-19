class ApplyForEventsController < ApplicationController
  def create
    apply = current_user.apply_for_events.create(event_id: params[:event_id])
    redirect_to events_url, notice: "#{apply.event.user.profile.nickname}さんのブログをお気に入り登録しました"
  end
  def destroy
    apply = current_user.apply_for_events.find_by(id: params[:id]).destroy
    redirect_to events_url, notice: "#{apply.event.user.profile.nickname}さんのブログをお気に入り解除しました"
  end

  def toggle_status
    apply = ApplyForEvent.find(params[:apply_for_event_id])
    apply.toggle_status!(status: apply.status)
    @matching_member = apply.user
    MatchingMailer.matching_mail(@matching_member).deliver
    @unmatching_members = ApplyForEvent.where.not(user_id: apply.user_id)
    @unmatching_members.each do |unmatching_member|
    UnmatchingMailer.unmatching_mail(unmatching_member.user).deliver
    end
    render complete_events_path
  end
end
