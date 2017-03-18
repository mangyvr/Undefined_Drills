class UsersController < ApplicationController

  # before_action :authorize

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  private


  def user_params
    params.require(:user).permit([:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :provider,
                                 :uid,
                                 :oauth_token,
                                 :oauth_secret,
                                 :oauth_raw_data])
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
