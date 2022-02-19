class ProductsController < ApplicationController
  before_action :set_product, only: [:update, :show, :destroy]
  # index renders all items in the products table
  def index
    products = Product.all 
    render_success 200, true, 'Products fetched successfully', products.as_json
  end

  # this action lets us create a new product
  # if the product saves correctly, we render the json data for the product.
  # if the product does not save correctly we render an error object.
  def create
    product = Product.new(prod_params)

    if product.save
      render json: product, status: 200
    else
      render json: {error: "Error creating review."}
    end

    return_error 500, false, errors, {}
  end

  # update the products api
  def update
    if @product.update(prod_params)
      render_success 200, true, 'Product updated successfully', @product.as_json
    else
      if @product.errors
        errors = @product.errors.full_messages.join(", ")
      else
        errors = 'Product update failed'
      end

      return_error 500, false, errors, {}
    end
  end


  # this method looks for the product id and if it is found we render the json object
  # otherwise we render an error object
  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: product, status: 200
    else
      render json: {error: "Product Not Found."}
    end
  end

  # delete product api
  def destroy
    @product.destroy

    render_success 200, true, 'Product deleted successfully', {}
  end

  # this private method is only available to this controller.
  # it uses the built-in methods .require and .permit provided by action controller
  private
    def prod_params
      params.require(:product).permit([:name, :brand, :price, :description])
    end

    # set the product object and retrun error when product is nil
    def set_product
      @product = Product.where(id: params[:id]).first

      unless @product
        return return_error 404, false, 'Product not found', {}
      end
    end
end
