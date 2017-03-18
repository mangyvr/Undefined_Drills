class Drill < ApplicationRecord

  belongs_to :group
  has_many :answers, dependent: :destroy
  has_many :user_drills
  has_many :completers, through: :user_drills, source: :user

end

# # use this in users_controller, lists all completed drills
# # -----------
#
# before_action(:find_drills, { only: [:whatever_actions_you_want] })
#
# def find_drills
#   @user = current_user
#    @drills = Drill.joins(:completers).where(:completed_drills => {:user_id => @user.id})
#  end
