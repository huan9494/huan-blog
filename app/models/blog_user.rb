class BlogUser < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  enum action: [:biglike, :like, :dislike, :bigdislike]
end
