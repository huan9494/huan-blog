class Admin::BlogsController < ApplicationController

  layout 'admin'
  before_action :set_blog, only: [:show, :edit, :destroy, :update]
  def index
    @blogs = Blog.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end
  def show
  end
  def new
    @blog = Blog.new
  end
  def create
    @category = Category.where(name: params[:category]).first
    @blog = @category.blogs.new(blog_params)
    if @blog.save
      redirect_to admin_root_path
    else
      render 'new'
    end
  end
  def edit
  end
  def update
    if @blog.update(blog_params)
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
    params.require(:blog).permit(:title, :body, :published, :promoted,
                                 :publish, :image, :category,
                                 :author_name, :author_position, :author_age, :author_avatar)
  end
end