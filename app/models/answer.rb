class Answer < ApplicationRecord
  belongs_to :drill

  # VALIDATIONS
  validates :body, presence: true
end
