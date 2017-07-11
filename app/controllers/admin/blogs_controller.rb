class Admin::BlogsController < ApplicationController

  layout 'admin'
  before_action :set_blog, only: [:show, :edit, :destroy]
  def index
    @blogs = Blog.order("created_at DESC")
  end
  def show
  end
  def new
    @blog = Blog.new
  end
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to admin_root_path
    else
      render 'new'
    end
  end
  def edit
  end
  def update
    @blog = Blog.update(blog_params)
    if @blog.update
      redirect_to admin_root_path
    else
      render 'edit'
    end
  end
  def destroy
    redirect_to admin_root_path
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end
  def blog_params
    Params.require(:blog).permit(:title, :body, :published, :promoted,
                                 :publish, :image, :category_id,
                                 :author_name, :author_position, :author_age, :author_avatar,
                                 :biglikes_count, :likes_count, :dislikes_count, :bigdislikes_count)
  end
end