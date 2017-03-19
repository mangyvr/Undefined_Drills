class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, alert: 'Please sign in' unless user_sign_in?
  end

  def user_sign_in?
    session[:user_id].present?
  end
  helper_method :user_sign_in?

  def current_user
    User.find session[:user_id] if user_sign_in?
  end
  helper_method :current_user

  def find_user
    @user = User.find params[:id]
  end
  helper_method :find_user_authorize

  def authorize
    if cannot?(:manage, @user)
      redirect_to root_path, alert: 'Not Authorized!'
    end
  end
  helper_method :authorize

end
