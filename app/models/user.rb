class User < ApplicationRecord
  # has_secure_password
  # validates :email, presence: true, uniqueness: true,
  #         format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :password_confirmation, presence: true
  has_many :drills
  has_many :answers
  has_many :completed_drills, through: :drills, source: :user 


end
