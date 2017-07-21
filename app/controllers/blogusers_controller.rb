class BlogusersController < ApplicationController
  def update
    blog_user = BlogUser.where(user_id: params[:user_id], blog_id: params[:blog_id]).first
    blog_user.update(action: params[:user_action])
  end
end