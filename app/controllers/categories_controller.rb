class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]

  def new
    if current_user.role != "admin"
      flash[:error] = "You do not have access"
      redirect_to root_path
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category added successfully"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find_by slug: params[:id]
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
