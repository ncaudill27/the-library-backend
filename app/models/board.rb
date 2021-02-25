class Board < ApplicationRecord
  belongs_to :club
  # belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
end
