class DrillsController < ApplicationController
  before_action :find_drill, only: [:show, :edit, :update, :destroy]

  def index

    # Show drills for this group only
    # render json:params
    @drills = Drill.order(created_at: :desc).where(group_id: params[:group_id])
    @group_id = params[:group_id]

  end

  def new
    @group = Group.find (params[:group_id])
    @drill = Drill.new
  end

  def create
    @drill  = Drill.new(drill_params)
    @drill.user = current_user
    if @drill.save
      flash[:notice] = 'Drill created successfully'
      redirect_to drill_path(@drill)
    else
      flash.now[:alert] = 'Please fix errors below'
      render :new
    end
  end

  def show

    @drill = Drill.find params[:id]
    @user_answer ||= ""

    # params.require(:drill).permit([:id])
    # render json:params

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
    params.require(:drill).permit([:title, :description])
  end

  def find_drill
    @drill = Drill.find params[:id]
  end

end
