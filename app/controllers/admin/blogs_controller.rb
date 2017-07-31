module Admin
  #Admin blog
  class BlogsController < ApplicationController
    layout 'admin'
    before_action :set_blog, only: [:show, :edit, :destroy, :update]
    DEFAULT_IMAGE_URL = "/assets/thumb_author_avatar.png"

    def default_admin_page
    end

    def index
      # @blogs = Blog.order("id ASC").paginate(page: params[:page], per_page: 20)
      # @blogs = Blog.search("*",order: {id: :asc}, page: params[:page], per_page: 20)
      # sort = Blog.sort_funct(params[:sort])
      # @blogs = Blog.find_excute(params[:category], params[:published],
      #                           params[:promoted], params[:query], sort).
      #                           paginate(page: params[:page], per_page: 20)
      @blogs = Blog.search_category(params[:category])
                   .search_published(params[:published])
                   .search_promoted(params[:promoted])
                   .search_title(params[:query])
                   .select(:id, :created_at, :category,
                           :title, :promoted, :author_name,
                           :author_avatar, :published, :publish)
                   .order_blog(params[:sort])
                   .paginate(page: params[:page],
                             per_page: 20)
    end

    def show
    end

    def new
      @blog = Blog.new
    end

    def create
      @blog = Blog.new(blog_params)
      if params[:blog][:image] == DEFAULT_IMAGE_URL
        @blog.image = File.open(Rails.root.to_s + "/app/assets/images/thumb_author_avatar.png")
      else
        @blog.image = File.open(Rails.root.to_s + "/public/" + params[:blog][:image])
      end

      if params[:blog][:author_avatar] == DEFAULT_IMAGE_URL
        @blog.author_avatar = File.open(Rails.root.to_s + "/app/assets/images/thumb_author_avatar.png")
      else
        @blog.author_avatar = File.open(Rails.root.to_s + "/public/" + params[:blog][:author_avatar])
      end

      if @blog.save
        flash[:notice] = 'Create successfully!'
        Blog.delete_cached_blog_count
        redirect_to admin_root_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
      if params[:blog][:image] == DEFAULT_IMAGE_URL
        @blog.update(image: File.open(Rails.root.to_s + "/app/assets/images/thumb_author_avatar.png"))
      else
        @blog.update(image: File.open(Rails.root.to_s + "/public/" + params[:blog][:image]))
      end

      if params[:blog][:author_avatar] == DEFAULT_IMAGE_URL
        @blog.update(author_avatar: File.open(Rails.root.to_s + "/app/assets/images/thumb_author_avatar.png"))
      else
        @blog.update(author_avatar: File.open(Rails.root.to_s + "/public/" + params[:blog][:author_avatar]))
      end
      
      if @blog.update(blog_params)
        flash[:notice] = 'Update successfully!'
        redirect_to admin_blogs_path unless params[:redirect_check]
      else
        render 'edit'
      end
    end

    def destroy
      flash[:notice] = 'Destroy successfully!'
      Blog.delete_cached_blog_count
      redirect_to admin_root_path
    end

    def search
      sort = Blog.sort_funct(params[:sort])
      @blog_search = Blog.find_excute(params[:category], params[:published],
                                      params[:promoted], params[:query], sort)
                                                        .paginate(page: params[:page], per_page: 20)


      # if params[:query].length > 0
      #   @blogs = search_query(params[:query])
      # else
      #   @blogs = search_query("*")
      # end
      
    end

    def confirm
      @blog = Blog.new(blog_params)
      

      if params[:id]
        render 'edit' if @blog.invalid?
      else
        render 'new' if @blog.invalid?
      end
      if params[:blog][:action]
        puts @blog.title
      end
    end

    private

    def set_blog
      @blog = Blog.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :body, :published, :promoted,
                                   :publish, :image, :category,
                                   :author_name, :author_position,
                                   :author_age, :author_avatar, :remote_image_url,
                                   :remote_author_avatar_url)
    end

    def search_query(query)
      Blog.search(query, fields: [{ title: :word_start }],
                         where: { category: params[:category],
                                  published: params[:published],
                                  promoted: params[:promoted] },
                         order: { id: :asc },
                         page: params[:page], per_page: 20)
    end
  end
end