class CancelMailer < ApplicationMailer
  def cancel_mail(cancel_info)
    @cancel_info = cancel_info
    mail to: @cancel_info.event.user.email, subject: 'キャンセル申請がありました'
  end
end
