class ValidateEmailController < ApplicationController
  def new
    @user = User.find_by_id params[:user_id]

    if @user
      token = User.new_token

      @user.email_validation_token = User.hash_token(token)
      @user.email_validation_sent_at = Time.zone.now

      if @user.save
        EmailValidationMailer.send_email_validation_to_user(@user, @user.gen_email_validation_link(request.base_url, token, @user)).deliver_later
        redirect_to root_path, notice: "Validation email sent."
      else
        redirect_to root_path, alert: "Validation email failed."
      end
    else
      redirect_to root_path, alert: "User not found."
    end
  end

  def edit
  end

  def update
    @user = User.find_by_id params[:user_id]

    if @user
      if BCrypt::Password.new(@user.email_validation_token) != params[:id]
        redirect_to root_path, alert: "Link is invalid."
      elsif (@user.email_validation_sent_at + 3.days) < Time.now
        # Token has expired -- destroy the user since this allows for account recreation
        @user.destroy
        redirect_to root_path, alert: "Link is expired.  Please recreate your account."
      else
        if @user.update_attribute("valid_email", true)
          @user.update_attribute("password_reset_token", '')

          User.where({is_admin: true}).each do |admin|
            EmailValidationMailer.send_email_validation_to_admin(admin, @user).deliver_later
          end

          redirect_to root_path, notice: "Email validated."
        else
          redirect_to root_path, alert: "Email validation failed."
        end
      end
    else
      redirect_to root_path, alert: "Invalid user."
    end
  end
end
