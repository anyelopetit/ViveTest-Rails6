# frozen_string_literal: true

# Job to create every product
class ProductCreatorJob < ApplicationJob
  queue_as :default

  def perform(loader, product_params)
    # Product without assigned loader because the loader can't be saved
    # if its products can't be saved
    product =
      Product.new(product_params.as_json(only: [:name, :description]))

    if product.valid?
      # Just in case the product is valid will be related to this loader
      product.loader_id = loader.id

      # Let's collect only valid variants to create the product
      valid_variants = []
      
      # First we verify if there are valid variants before create the product
      if (variants = product_params['variants']).present?
        # Processing variants
        variants.each do |variant|
          variant = variant.to_hash.to_dot # https://github.com/adsteel/hash_dot
          # Variant without assigned product because the product can't be saved
          # if its variants can't be saved
          new_variant = Variant.new(name: variant.name, price: variant.price)

          if new_variant.valid?
            # Just in case the variant is valid will be related to this product
            valid_variants.push(new_variant)
          end
        end
      end
    end

    if valid_variants.present? && product.save
      # Assigning valid variants to this valid product
      valid_variants.each do |variant|
        variant.product_id = product.id
      end
    else
      # If the product can't be saved, then will be added to the loader's
      # failed_products
      product_with_errors = product.as_json.merge(errors: product.errors)
      loader.failed_products.push(product_with_errors)
      loader.save!
    end
  end
end
