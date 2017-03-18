class GroupsController < ApplicationController
  before_action :get_group_id, except: [:index, :new, :create]
  before_action :get_bookmarks, only: [:index]
<<<<<<< HEAD


  def index
    @groups = Group.order(created_at: :desc)
=======

  def index
    @groups = Group.order(created_at: :desc)
    # @user_groups = Group.where???
    # render json: @groups
>>>>>>> 5daca840a5a4f5ae2d05deedaaa2836c2c548610
  end

  def show
    @drills = Drill.where(group: @group)
    render json: @group
  end

  def new
    render plain: "For Admin Use Only"
  end

  def new
    @group = Group.new
  end

  def create


    # render plain: "Creation of Groups is Admin Only"
    # ***Uncomment once admin is defined***
    group_params = params.require(:group).permit(:title)
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path(@group), notice: "Group Created Successfully"
    else
      render new_group_path, alert: "Group NOT Created Successfully"
    end
  end

  def edit

  end

  def update
    # render plain: "Editing of Groups is Admin Only"
    # ***Uncomment once admin is defined***
    group_params = params.require(:group).permit(:title)
    if @group.update(group_params)
      redirect_to groups_path(@group), notice: "Group Updated Successfully"
    else
      render group_edit_path(@group), notice: "Group NOT Updated Successfully"
    end
  end

  def destroy
    # render plain: "Destroying Groups is Admin Only"
    # ***Uncomment once admin is defined***
    if @group.destroy
      redirect_to groups_path, notice: "Group Successfully Destroyed"
    else
      redirect_to groups_path(@group), alert: "Group NOT Destroyed Successfully"
    end
  end


  private

  def get_bookmarks
  #  @usergroups = UserGroups.find_by_user_id session[:user_id]

  end

  def get_group_id
    @group = Group.find params[:id]
  end

end
