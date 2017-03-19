class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, alert: 'Access Denied! Please Sign In' unless user_sign_in?
  end

  def user_sign_in?
    session[:user_id].present?
  end
  helper_method :user_sign_in?

  def current_user
    User.find session[:user_id] if user_sign_in?
  end
  helper_method :current_user

end
