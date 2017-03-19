class Answer < ApplicationRecord
  belongs_to :drill
  belongs_to :user

  # VALIDATIONS
  validates :body, presence: true
end
