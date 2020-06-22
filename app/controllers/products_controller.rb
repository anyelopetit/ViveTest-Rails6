# frozen_string_literal: true

class ProductsController < ApplicationController

  # GET / (root)
  def index
    @products = Product.all.order(created_at: :desc)
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
  end

  # POST /products
  def create
    @loader = Loader.create
    ProductsPayloadJob.perform_later(@loader, products_params)
    head :created
  end

  private

  def products_params
    params[:_json].map do |product|
      product.permit(
        :name,
        :description,
        {
          variants: [:name, :price]
        }
      )
    end
  end
end