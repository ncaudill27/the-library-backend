class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  validates_associated :memberships

  has_many :clubs, through: :memberships
  has_many :comments, dependent: :destroy
  has_many :boards, through: :comments
  
  has_secure_password
end
