# frozen_string_literal: true

# Job to processing the payload for the creation of multiple products
class ProductsPayloadJob < ApplicationJob
  queue_as :default

  def perform(loader, products_params)
    products_params.each do |product_params|
      # Avoid create products without variants
      next if product_params['variants'].blank?

      ProductCreatorJob.perform_later(loader, product_params)
    end
  end
end