class SessionsController < ApplicationController

  # before_action :authorize, only: [:create]

  def new
  end

  def create
    user = User.find_by_email params[:email].downcase
    if user.is_validated == false || user.valid_email == false
      redirect_to root_path, alert: 'Waiting for Permission'
      return
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Signed In'
    else
      flash.now[:alert] = 'Wrong credentials'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end

  private
  # def authorize
  #
  #   if @user.is_validated == false || @user.valid_email == false
  #     redirect_to root_path, alert: 'Not authorized!'
  #   end
  # end

end
