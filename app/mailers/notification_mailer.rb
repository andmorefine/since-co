class NotificationMailer < ApplicationMailer
  default from: "info@andmorefine.com"

  def send_confirm_to_user(contact)
    @contact = contact
    mail(
      subject: "お問い合わせを受け付けました。", #メールのタイトル
      to: @contact.email #宛先
    ) do |format|
      format.text
    end
  end
end
