class UnmatchingMailer < ApplicationMailer
  def unmatching_mail(unmatching_member)
    @unmatching_member = unmatching_member
    mail to: @unmatching_member.email, subject: "マッチング不成立のお知らせ"
  end
end
