class Admin::CategoriesController < ApplicationController

  layout 'admin'
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      Category.delete_cached_category
      redirect_to admin_root_path
    else
      render 'new'
    end
  end
  def edit
    @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_root_path
    else
      render 'edit'
    end
  end
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    Category.delete_cached_category
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end