class UserGroupsController < ApplicationController
before_action :authenticate_user!
before_action :find_bookmark, only: [:destroy]
before_action :find_group, only: [:create]

def create
  # if cannot? :bookmark, @group
  #   redirect_to group_path(@group), alert: 'Some alert'
  #   return
  # end

  bookmark = UserGroup.new(user: current_user, group: @group)

  if bookmark.save
    redirect_to group_drills_path(@group), notice: 'Bookmark saved!'
  else
    redirect_to group_drills_path(@group), alert: 'Could not bookmark!'
  end
end

def destroy
  @group = @bookmark.group
  # if cannot? :bookmark, @group
  #   redirect_to group_path(@group), alert: 'Not allowed!'
  # end

  redirect_to(
    group_drills_path(@bookmark.group),
    @bookmark.destroy ? {notice: 'Bookmark removed!'} : {alert: @bookmark.errors.full_messages.join(', ')}
  )
end

private
def find_bookmark
  @bookmark ||= UserGroup.find(params[:id])
end

def find_group
  @group ||= Group.find(params[:group_id])
end
end
