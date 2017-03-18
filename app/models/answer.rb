class Answer < ApplicationRecord
  belongs_to :drill, dependent: :destroy

end
