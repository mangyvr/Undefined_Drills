class Admin::DashboardController < Admin::BaseController
  before_action :find_user, only: [:activate_user, :validate_user]
  before_action :authenticate_user!

  def index
    @drill_count = Drill.count
    @answer_count   = Answer.count
    @user_count     = User.count
    @users = User.all
  end

  def validate_user
    if @user.update(is_admin: true)
      flash[:alert] = 'User Validated!'
      redirect_to admin_dashboard_index_path
    end
  end

  def activate_user
    if @user.update(is_admin: true)
      flash[:alert] = 'User Activated!'
      redirect_to admin_dashboard_index_path
    end
  end

  private

  def find_user
    @user = User.find params[:id]
  end


end
