class BlogUser < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  enum action: [:not_choose, :biglike, :like, :dislike, :bigdislike]

  def self.update_action_count(blog_id)
    a = BlogUser.where(blog_id: blog_id).select(:action).group(:action).count
    a["biglike"] = 0 unless a["biglike"]
    a["like"] = 0 unless a["like"]
    a["dislike"] = 0 unless a["dislike"]
    a["bigdislike"] = 0 unless a["bigdislike"]
    Blog.find(blog_id).update(biglikes_count: a["biglike"], likes_count: a["like"],
                                dislikes_count: a["dislike"], bigdislikes_count: a["bigdislike"])
  end

end
