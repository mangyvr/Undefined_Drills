class ValidateEmailController < ApplicationController
  def new
    @user = User.find_by_id params[:user_id]

    if @user
      token = User.new_token

      @user.email_validation_token = User.hash_token(token)
      @user.email_validation_sent_at = Time.zone.now

      if @user.save
        # ResetPasswordMailer.send_reset_password_link(@user, @user.gen_reset_link(request.base_url, token)).deliver_now
        p @user.gen_email_validation_link(request.base_url, token, @user)
        redirect_to root_path, notice: "Validation email sent."
      else
        redirect_to root_path, alert: "Validation email failed."
      end
    else
      redirect_to root_path, alert: "Invalid email."
    end
  end

  def edit
  end

  def update
    # permitted_params = params.require(:reset_password).permit(:password, :password_confirmation, :email)
    @user = User.find_by_id params[:user_id]

    if @user
      if BCrypt::Password.new(@user.email_validation_token) != params[:id]
        redirect_to root_path, alert: "Link is invalid."
      elsif (@user.email_validation_sent_at + 3.days) < Time.now
        # Token has expired -- destroy it
        @user.update_attribute("password_reset_token", '')
        redirect_to root_path, alert: "Link is expired."
      else
        if @user.update_attribute("valid_email", true)
          @user.update_attribute("password_reset_token", '')
          redirect_to root_path, notice: "Email validated."
        else
          redirect_to root_path, notice: "Email validation failed."
        end
      end
    else
      redirect_to root_path, notice: "Invalid link."
    end
  end
end
