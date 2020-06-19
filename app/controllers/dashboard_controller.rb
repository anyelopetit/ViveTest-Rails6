# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @total_products = Loader.total_products
    @succeeded_products = Product.all
    @failed_products = Loader.failed_products
    @loaders = Loader.all.order(created_at: :desc)
  end
end