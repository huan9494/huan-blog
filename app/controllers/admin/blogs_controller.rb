class Admin::BlogsController < ApplicationController

  layout 'admin'
  before_action :set_blog, only: [:show, :edit, :destroy, :update]
  def default_admin_page   
  end
  
  def index
    @blogs = Blog.order("id ASC").paginate(page: params[:page], per_page: 20)
    # @blogs = Blog.search("*",order: {id: :asc},page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.js
    end
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
    if @blog.update(blog_params)
      redirect_to admin_root_path unless params[:redirect_check]
    else
      render 'edit'
    end
  end
  def destroy
    redirect_to admin_root_path
  end
  def search
    sort = Blog.sort_funct(params[:sort])
    @blogs = Blog.find_excute(params[:category], params[:published],
                              params[:promoted], params[:query], sort).
                              paginate(page: params[:page], per_page: 20)
    # if params[:query].length > 0
    #   @blogs = search_query(params[:query])
    # else
    #   @blogs = search_query("*")
    # end
    
  end
  def confirm
    @blog = Blog.new(blog_params)
    render "new" if @blog.invalid?
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
  def search_query(query)
    Blog.search(query, fields: [{title: :word_start}],
                       where: {category: params[:category],
                               published: params[:published],
                               promoted: params[:promoted]},
                        order: {id: :asc },
                       page: params[:page], per_page: 20)
  end
end