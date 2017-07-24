class Blog < ApplicationRecord
  # searchkick word_start: [:title], callbacks: :async,
  #            highlight: [:title], searchable: [:title],
  #            filterable: [:title, :published, :promoted, :category, :id]
  enum published: [:not_published, :published]
  enum promoted: [:not_promoted, :promoted]
  validates :title, length: {maximum: 255},
                    presence: true
  validates :publish, presence: true
  validates :body, presence: true
  validates :category, presence: true
  validates :author_name, length: {maximum: 32},
                          presence: true
  validates :author_position, length: {maximum: 32},
                              presence: true
  validates :author_age, presence: true, numericality: {only_integer: true, greater_than: 0, less_than: 100}

  has_many :blog_users
  has_many :comments, dependent: :destroy
  
  mount_uploader :image, FileUploader
  mount_uploader :author_avatar, FileUploader
  validates_integrity_of :image
  validates_integrity_of :author_avatar

  # scope :find_excute, -> (category, published, promoted, query, sort){where("category LIKE ? AND published LIKE ? AND promoted LIKE ?",
  #                                                                           "%#{category}%", "%#{published}%", "%#{promoted}%").
  #                                                                           where("title LIKE ?", "%#{query}%").
  #                                                                           order(sort)}
  
  def self.order_blog(param)
    if param
      if param == "ASC"
        order("created_at ASC")
      elsif param == "DESC"
        order("created_at DESC")
      else
        all
      end
    else
      all
    end 
  end
  def self.search_category(param)
    if param
      if param.length > 0
        where(category: param)
      else
        all
      end
    else
      all
    end
  end

  def self.search_published(param)
    if param
      if param.length > 0
        where(published: param)
      else
        all
      end
    else
      all
    end
  end

  def self.search_promoted(param)
    if param
      if param.length > 0
        where(published: param)
      else
        all
      end
    else
      all
    end
  end

  def self.search_title(param)
    if param
      if param.length > 0
        where("title LIKE ?", "%#{param}%")
      else
        all
      end
    else
      all
    end
  end

  def self.cache_blog_count
    Rails.cache.fetch("blog_count") do
     Blog.all.count
    end
  end
  def self.delete_cached_blog_count
    Rails.cache.delete("blog_count")
  end

end
