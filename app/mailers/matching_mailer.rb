class MatchingMailer < ApplicationMailer
  def matching_mail(matching_member)
    @matching_member = matching_member
    mail to: @matching_member.email, subject: "マッチング成立のお知らせ"
  end
end
