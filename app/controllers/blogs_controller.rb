class BlogsController < ApplicationController

  before_action :set_blog, only: [:show]
  
  def index
    @blogs = Blog.select(:id, :title, :category, :publish, :promoted, :biglikes_count, :likes_count, :dislikes_count, :bigdislikes_count).order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end
  def show
    @blog = Blog.find(params[:id])

    if current_user
      @action = BlogUser.where(user_id: current_user.id, blog_id: @blog.id).first
      if @action
        @check_action = @action.action
      end
    end

    @count_action = BlogUser.where(blog_id: @blog.id).select(:action).group(:action).count
    
    @blog_comments = @blog.comments.order("created_at ASC")
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end
end