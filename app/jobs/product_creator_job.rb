# frozen_string_literal: true

# Job to create every product
class ProductCreatorJob < ApplicationJob
  queue_as :default

  def perform(loader, product_params)
    # Product without assigned loader
    product =
      Product.new(product_params.as_json(only: [:name, :description]))

    if product.valid?
      # Just in case the product is valid will be related to this loader
      product.loader_id = loader.id
      
      # Processing variants
      product_params['variants'].each do |variant|
        variant = variant.to_hash.to_dot # https://github.com/adsteel/hash_dot
        product.variants.new(name: variant.name, price: variant.price)
      end
    else
      loader.failed_products.push(product)
      loader.save!
    end

    unless product.save
      # If the product creation failed, then will be added to the loader's
      # failed_products
      loader.failed_products.push(product)
      loader.save!
    end
  end
end
