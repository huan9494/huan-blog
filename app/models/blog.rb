class Blog < ApplicationRecord
  belongs_to :category
  enum published: [:not_published, :published]
  enum promoted: [:not_promoted, :promoted]
  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  validates :author_name, presence: true, length: {maximum: 32}
  validates :author_position, presence: true, numericality: true, length: {maximum: 2}
  validates :author_age, presence: true, length: {maximum: 32}

  has_many :blog_users

  mount_uploader :image, FileUploader
  mount_uploader :author_avatar, FileUploader
end
