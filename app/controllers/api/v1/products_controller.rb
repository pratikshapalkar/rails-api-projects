class Api::V1::ProductsController < ApplicationController
  # index renders all items in the products table
  def index
    products = Product.all 
    render json: products, status: 200
  end

  # this action lets us create a new product
  # if the product saves correctly, we render the json data for the product.
  # if the product does not save correctly we render an error object.
  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price],
      description: prod_params[:description]
    )
    if product.save
      render json: product, status: 200
    else
      render json: {error: "Error creating review."}
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

  # this private method is only available to this controller.
  # it uses the built-in methods .require and .permit provided by action controller
  private
    def prod_params
      params.require(:product).permit([:name, :brand, :price, :description])
    end
end
