class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, presence: true, uniqueness: {scope: :user}
  validates :user_id, presence: true
end
