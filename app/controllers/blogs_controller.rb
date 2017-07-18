class BlogsController < ApplicationController

  before_action :set_blog, only: [:show]
  
  def index
    @blogs = Blog.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end
  def show
    
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end
end