class Group < ApplicationRecord
  has_many :drills, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :bookmarkers, through: :user_groups, source: :user


end
