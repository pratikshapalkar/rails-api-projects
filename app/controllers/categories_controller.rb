class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_category, only: [:update, :show, :destroy]
  
  # This action fetch all the categories of product
  def index
    categories = @product.categories
    render_success 200, true, 'Products fetched successfully', products.as_json
  end

  # this action lets us create a new category
  def create
    category = @product.categories.new(category_params)

    if category.save
      render_success 200, true, 'Language created successfully', category.as_json
    else
      if category.errors
        errors = category.errors.full_messages.join(", ")
      else
        errors = 'Language creation failed'
      end

      return_error 500, false, errors, {}
    end
  end

  # Update category API
  def update
    if @category.update(category_params)
      render_success 200, true, 'Language updated successfully', @category.as_json
    else
      if @category.errors
        errors = @category.errors.full_messages.join(", ")
      else
        errors = 'Language update failed'
      end

      return_error 500, false, errors, {}
    end
  end

  # Fetch an category API
  def show
    render_success 200, true, 'Category fetched successfully', @category.as_json
  end

  # Delete an category API
  def destroy
    @category.destroy

    render_success 200, true, 'Category deleted successfully', {}
  end
  private

  # Params of Category
  def category_params
    params.require(:category).permit(:type)
  end


  ## Set category Object, Return Error if not found
  def set_category
    @category = @product.categories.where(id: params[:id]).first

    unless @category
      return return_error 404, false, 'Category not found', {}
    end
  end
end
