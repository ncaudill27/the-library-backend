class Club < ApplicationRecord
  has_many :memberships, dependent: :destroy
  validates_associated :memberships

  has_many :users, through: :memberships
  has_many :boards, dependent: :destroy
end
