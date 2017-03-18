class Admin::DashboardController < Admin::BaseController

  def index
    @drill_count = Drill.count
    @answer_count   = Answer.count
    @user_count     = User.count
    @users = User.all
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  # def destroy
  #   @user = current_user
  #   @user.destroy
  #   session[:user_id] = nil
  #   redirect_to root_path, notice: 'Account deleted!'
  # end

end
