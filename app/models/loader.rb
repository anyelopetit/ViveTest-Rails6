class Loader < ApplicationRecord
  has_many :products

  # serialize :failed_products

  def total_products
    products.to_a + failed_products
  end

  def self.total_products
    all.map do |loader|
      loader.total_products
    end.flatten
  end

  def self.failed_products
    all.map do |loader|
      loader.failed_products
    end.flatten
  end
end
