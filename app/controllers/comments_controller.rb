class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:comment][:blog_id])
    @comment = @blog.comments.create(comment_params)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :blog_id)
  end
end