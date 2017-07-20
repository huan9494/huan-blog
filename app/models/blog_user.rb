class BlogUser < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  enum action: [:not_choose, :biglike, :like, :dislike, :bigdislike]
end
