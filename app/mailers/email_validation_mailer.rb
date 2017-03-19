class EmailValidationMailer < ApplicationMailer
  def send_email_validation_to_user(user, link)
    @user = user
    @link = link

    mail(to: @user.email, subject: "Email Validation for Undefined Drills")
  end

end
