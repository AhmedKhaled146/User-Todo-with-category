class CategoryController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:update, :show, :destroy]

  def index
    @categories = current_user.categories.page(params[:page]).per(4)
    render json: @categories, meta: pagination_meta(@categories)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @category
  end

  def update
    if @category.update(category_params)
      render json: @category, message: "Category Name is Updated successfully"
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      render json: { message: "#{@category.name} Category Was Deleted" }
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  private

  def pagination_meta(categories)
    {
      current_page: categories.current_page,
      next_page: categories.next_page,
      prev_page: categories.prev_page,
      total_pages: categories.total_pages,
      total_count: categories.total_count
    }
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Category not found" }, status: :not_found
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
