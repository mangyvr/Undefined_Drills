class Answer < ApplicationRecord
  belongs_to :drill
  belongs_to :user

  before_save :generate_hint

  # VALIDATIONS
  validates :body, presence: true

  def generate_hint
    self.hint = self.body.gsub(/[^aeiou]/i, "-")
  end

end
