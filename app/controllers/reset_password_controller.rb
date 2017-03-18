class ResetPasswordController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:reset_password][:email].downcase)

    if @user
      token = User.new_token

      # For now display token and url on terminal
      p @user.gen_reset_link(request.base_url, token)

      @user.password_reset_token = User.hash_token(token)
      @user.reset_sent_at = Time.zone.now

      if @user.save
        redirect_to posts_path, notice: "Password reset email sent."
      else
        render :new, notice: "Reset failed."
      end
    else
      render :new, notice: "Invalid email."
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
          redirect_to posts_path, notice: "Link is invalid."
        elsif (@user.reset_sent_at + 3.days) < Time.now
          # Token has expired -- destroy it
          @user.update_attribute("password_reset_token", '')
          redirect_to posts_path, notice: "Link is expired."
        else
          if @user.update permitted_params
          # if @user.update()
            @user.update_attribute("password_reset_token", '')
            redirect_to posts_path, notice: "Password changed."
          else
            redirect_to posts_path, notice: "Password changed failed."
          end
        end

      else
        flash.now[:alert] = "Passwords do not match."
        render :edit
      end
    else
      redirect_to root_path, notice: "Invalid link."
    end
  end

end
