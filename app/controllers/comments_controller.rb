# Comment controller
class CommentsController < ApplicationController
  def create
    @blog = Blog.find(params[:comment][:blog_id])
    if params[:comment][:body].present?
      @comment = @blog.comments.create(comment_params)
      @comment.user = current_user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :blog_id, :user_id)
  end
end
