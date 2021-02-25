class ClubSerializer < BaseSerializer
  attributes :name, :description, :avatar, :active_book_isbn13

  has_many :boards 
end
