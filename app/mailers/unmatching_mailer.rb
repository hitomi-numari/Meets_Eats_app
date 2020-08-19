class UnmatchingMailer < ApplicationMailer
  def unmatching_mail(unmatching_info)
    @unmatching_info = unmatching_info
    mail to: @unmatching_info.user.email, subject: 'イベントの募集結果に関するお知らせ'
  end
end
