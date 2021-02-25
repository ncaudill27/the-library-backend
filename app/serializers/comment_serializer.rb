class CommentSerializer < BaseSerializer
  attributes :content, :created_at

  belongs_to :board
  belongs_to :user
end