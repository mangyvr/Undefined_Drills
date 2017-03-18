class ResetPasswordMailer < ApplicationMailer
  def send_reset_password_link(user, link)
    @user = user
    @link = link

    mail(to: @user.email, subject: "Reset Password for Undefined Drills")
  end
end
