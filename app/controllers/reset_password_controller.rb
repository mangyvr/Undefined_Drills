class ResetPasswordController < ApplicationController

  before_action :authorize, only: [:new, :create, :edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:reset_password][:email].downcase)

    if @user
      token = User.new_token

      @user.password_reset_token = User.hash_token(token)
      @user.reset_sent_at = Time.zone.now

      if @user.save
        ResetPasswordMailer.send_reset_password_link(@user, @user.gen_reset_link(request.base_url, token)).deliver_later

        redirect_to root_path, notice: "Password reset email sent."
      else
        render :new, alert: "Reset failed."
      end
    else
      render :new, alert: "Reset failed."
    end
  end

  def edit
  end

  def update
    permitted_params = params.require(:reset_password).permit(:password, :password_confirmation, :email)

    @user = User.find_by(email: params[:reset_password][:email].downcase)

    if @user
      if params[:reset_password][:password] == params[:reset_password][:password_confirmation]

        # Check if password token is too old or if it does not match digest
        # below if statement is same as:
        # unless BCrypt::Password.new(@user.reset_digest).is_password?(remember_token)

        if BCrypt::Password.new(@user.password_reset_token) != params[:id]
          redirect_to root_path, alert: "Link is invalid."
        elsif (@user.reset_sent_at + 3.days) < Time.now
          # Token has expired -- destroy it
          @user.update_attribute("password_reset_token", '')
          redirect_to root_path, alert: "Link is expired."
        else
          if @user.update permitted_params
          # if @user.update()
            @user.update_attribute("password_reset_token", '')
            redirect_to root_path, notice: "Password changed."
          else
            redirect_to root_path, alert: "Password changed failed."
          end
        end

      else
        flash.now[:alert] = "Passwords do not match."
        render :edit
      end
    else
      redirect_to root_path, alert: "Invalid link."
    end
  end

  private
  def authorize
    if cannot?(:manage, @user)
      redirect_to root_path, alert: 'Not Authorized! Please Sign In'
    end
  end

end
