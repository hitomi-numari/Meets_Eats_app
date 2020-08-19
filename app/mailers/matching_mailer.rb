class MatchingMailer < ApplicationMailer
  def matching_mail(matching_info)
    @matching_info = matching_info
    mail to: @matching_info.user.email, subject: 'イベントの募集結果に関するお知らせ'
  end
end
