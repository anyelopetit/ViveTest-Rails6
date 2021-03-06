class Product < ApplicationRecord
  belongs_to :loader, optional: true
  has_many :variants

  validates_presence_of :name, :description
  validates_uniqueness_of :name
end
