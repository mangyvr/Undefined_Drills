class Group < ApplicationRecord

  has_many :drills, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :bookmarkers, through: :user_groups, source: :user
  has_many :permittedusers, through: :user_group_permission, source: :user
  has_many :user_group_permission, dependent: :destroy

  # VALIDATIONS
  validates :title, presence: true, uniqueness: true

  def completion(x)


  end

  def bookmarked_by?(user, groups)
    if (UserGroup.exists?(:user => user) && UserGroup.exists?(:group => groups.id))
      return true
    else
      return false
    end
  end

  def bookmark_for(user)
    UserGroup.find_by(user_id: user)
  end

end
