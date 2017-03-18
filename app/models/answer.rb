class Answer < ApplicationRecord
  belongs_to :drill, dependent: :destroy
  validates :drill_id, uniqueness: {scope: :user_id}

end
