class Product < ApplicationRecord
  belongs_to :brands_category
  has_one :category, through: :brands_category
  has_one :brand, through: :brands_category
end
