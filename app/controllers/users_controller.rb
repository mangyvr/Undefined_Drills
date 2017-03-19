class UsersController < ApplicationController

  # before_action :authorize
  before_action :find_user, only: [:edit, :update, :edit_password, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: 'Account updated!'
    else
      render :edit
    end
  end

  def edit_password
    if @user && @user.authenticate(params[:user][:current_password])
      if params[:user][:current_password] != params[:user][:new_password]
        if params[:user][:new_password] == params[:user][:new_password_confirmation]
          @user.password = params[:user][:new_password]
          @user.save
          redirect_to root_path, notice: "Password Updated!"
        else
          flash[:alert] = "new password must match the new password confirmation"
          render :edit
        end
      else
        flash[:alert] = "New password must be different from the current password"
      end
    else
      flash[:alert] = "Wrong password"
      render :edit
    end
  end

  def destroy
    @user.destroy
    #session[:user_id] = nil unless URI(request.referer).path == '/admin/dashboard'
    redirect_to root_path, notice: 'Account deleted!'
  end

  private


  def user_params
    params.require(:user).permit([:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :is_admin,
                                 :is_validated,
                                 :provider,
                                 :uid,
                                 :oauth_token,
                                 :oauth_secret,
                                 :oauth_raw_data])
  end

  def find_user
    @user = User.find params[:id]
  end

  # def authorize
  #   if cannot?(:manage, @user)
  #     redirect_to root_path, alert: 'Not Authorized!'
  #   end
  # end

  # For password reset
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Generates password reset link with unencrypted token before it is digest-ed
  def gen_reset_link(url, token)
    "#{url}/reset_password/#{token}/edit?email=#{self.email}"
  end

  # Use bcrypt to convert unhashed token into digest
  def self.hash_token(token)
    BCrypt::Password.create(token)
  end

end
