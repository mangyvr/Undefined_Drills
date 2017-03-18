class Group < ApplicationRecord
  has_many :drills, dependent: :destroy


end
