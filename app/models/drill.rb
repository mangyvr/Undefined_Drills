class Drill < ApplicationRecord

  belongs_to :group

  has_many :answers, dependent: :destroy
  has_many :user_drills, dependent: :destroy
  has_many :attempters, through: :user_drills, source: :user

  # VALIDATIONS
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :level, presence: true, inclusion: {in: [1,2,3]}
  validates :points, presence: true
  validates :group_id, presence: true

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
