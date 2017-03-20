class DrillsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_drill, only: [:show, :edit, :update, :destroy]
  before_action :new_drill, only: [:new]
  before_action :new_drill_create, only: [:create]
  before_action :authorize, except: [:index, :show]

  def index
    @group = Group.find params[:group_id]
    # Show drills for this group only
    # render json:params
    @drills = Drill.order(created_at: :desc).where(group_id: params[:group_id])
    @group_id = params[:group_id]
    attempted = UserDrill.where(user: current_user, completed: false).pluck(:drill_id, :attempts)
    completed = UserDrill.where(user: current_user, completed: true).pluck(:drill_id)
    @completed_drills = Drill.find(completed)
    @attempted_drills = UserDrill.where(user: current_user, completed: false)
  end

  def new
    @group = Group.find (params[:group_id])
    # @drill = Drill.new
  end

  def create
    # render json:params
    @group = Group.find (params[:group_id])

    if @drill.save
      flash[:notice] = 'Drill created successfully'
      redirect_to drill_path(@drill)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  def show
    user_answer = params[:body] || ""
    @answer = Answer.new(user: current_user, drill: @drill, body: user_answer, approved: false)
  end

  def edit
  end

  def update
  if @drill.update drill_params
    redirect_to drill_path(@drill), notice: 'Drill Updated'
  else
    render :edit
  end
  end

  def destroy
    @drill.destroy
    redirect_to group_drills_path(@drill.group_id), notice: 'Drill Deleted'
  end

  private

  def drill_params
    params.require(:drill).permit([:title, :description, :group_id, :level, :points])
  end

  def find_drill
    @drill = Drill.find params[:id]
  end

  def new_drill
    @drill = Drill.new
    @drill.group_id = params[:group_id]
  end

  def new_drill_create
    @drill = Drill.new(drill_params)
    @drill.group_id = params[:group_id]
  end

  def authorize
    return if UserGroupPermission.where(group_id: @drill.group.id, user_id: current_user.id).present? || current_user.is_admin

    if cannot? :manage, Drill
      redirect_to groups_path, alert: "You are not authorized."
    end
    #
    # if UserGroupPermission.where(group_id: @drill.group.id, user_id: current_user.id).present? || current_user.is_admin
    # else
    # end
  end

end
