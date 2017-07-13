class Blog < ApplicationRecord
  enum published: [:not_published, :published]
  enum promoted: [:not_promoted, :promoted]
  validates :title, length: {maximum: 255},
            presence: {message: "^We need to know who is filling in this form (your name)"}
  validates :publish, presence: true
  validates :body, presence: true
  validates :author_name, presence: true, length: {maximum: 32}
  validates :author_position, presence: true, length: {maximum: 32}
  validates :author_age, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 100}

  has_many :blog_users

  mount_uploader :image, FileUploader
  mount_uploader :author_avatar, FileUploader
  validates_integrity_of :image
  validates_integrity_of :author_avatar

  scope :find_excute, -> (category, published, promoted, query, sort){where(category: category,
                                                                     published: published,
                                                                     promoted: promoted).where(
                                                                     "title LIKE ?", "%#{query}%").
                                                                     order(sort)}
  def self.sort_funct(sort)
    case sort
    when "ASC"
      "created_at ASC"
    else
      "created_at DESC"
    end
  end
end
