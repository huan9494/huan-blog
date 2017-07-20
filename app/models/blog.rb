class Blog < ApplicationRecord
  # searchkick word_start: [:title], callbacks: :async,
  #            highlight: [:title], searchable: [:title],
  #            filterable: [:title, :published, :promoted, :category, :id]
  enum published: [:not_published, :published]
  enum promoted: [:not_promoted, :promoted]
  validates :title, length: {maximum: 255, message: "255文字以内で入カしてください。"},
                    presence: {message: "タイトルを入カしてください。"}
  validates :publish, presence: {message: "公開日時を設定して下さい。"}
  validates :body, presence: {message: "名前を入カしてください。"}
  validates :category, presence: {message: "カテゴリを選択して下さい。"}
  validates :author_name, length: {maximum: 32, message: "32文字以内で入カしてください。"},
                          presence: {message: "名前を入カしてください。"}
  validates :author_position, length: {maximum: 32, message: "32文字以内で入カしてください。"},
                              presence: {message: "職業を入カしてください。"}
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

  self.inheritance_column = nil
  
  has_many :comments, dependent: :destroy
end
