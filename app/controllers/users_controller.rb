class UsersController < ApplicationController

  before_action :find_user
  before_action :authorize

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

  def find_user
    @user = User.find params[:id]
  end

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

  def authorize
    if cannot?(:manage, @user)
      redirect_to root_path, alert: 'Not Authorized!'
    end
  end

end
