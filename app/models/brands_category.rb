class BrandsCategory < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :products
end
