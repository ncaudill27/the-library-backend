class BoardSerializer < BaseSerializer
  attributes :title

  belongs_to :club
  has_many :comments
end
