class UserDrill < ApplicationRecord
  belongs_to :user
  belongs_to :drill

  # validates:
  validates :drill_id, presence: true, uniqueness: {scope: :user}
  validates :user_id, presence: true


end
