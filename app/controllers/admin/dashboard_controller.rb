class Admin::DashboardController < Admin::BaseController
  before_action :find_user, only: [:activate_user, :validate_user, :delete_user]
  before_action :find_drill, only: [:change_drill_metrics, :delete_drill]
  before_action :find_group, only: [:delete_group]
  before_action :find_answer, only: [:approve_answer, :delete_answer]
  before_action :authenticate_user!

  def index
    @counts = {drill_count: Drill.count, user_count: User.count, answer_count: Answer.count}
    @lists = {users: User.all, drills: Drill.all, answers: Answer.all, groups: Group.all}
    # render json: @lists
  end

  def delete_answer
    if @answer.destroy
      flash[:alert] = 'Answer Deleted!'
      redirect_to admin_dashboard_index_path
    end
  end

  def approve_answer
    if @answer.update(approved: true)
      flash[:alert] = 'Answer Approved!'
      redirect_to admin_dashboard_index_path
    end
  end

  def change_drill_metrics
    level = params[:level]
    points = params[:points]
    if @drill.update(level: level, points: points)
      flash[:alert] = 'Drill Level and Score Updated!'
      redirect_to admin_dashboard_index_path
    end
  end

  def delete_group
    if @group.destroy
      flash[:alert] = "Group Deleted!"
      redirect_to admin_dashboard_index_path
    end
  end

  def delete_drill
    if @drill.destroy
      flash[:alert] = "Drill Deleted!"
      redirect_to admin_dashboard_index_path
    end
  end

  def delete_user
    if @user.destroy
      flash[:alert] = 'User Deleted!'
      redirect_to admin_dashboard_index_path
    end
  end

  def validate_user
    if @user.update(is_validated: true)
      flash[:alert] = 'User Validated!'
      redirect_to admin_dashboard_index_path
    end
  end

  def activate_user
    if @user.update(is_admin: true)
      flash[:alert] = 'User Made Admin!'
      redirect_to admin_dashboard_index_path
    end
  end

  private

  def find_group
    @group = Group.find params[:id]
  end

  def find_user
    @user = User.find params[:id]
  end

  def find_drill
    @drill = Drill.find params[:id]
  end

  def find_answer
    @answer = Answer.find params[:id]
  end

end
