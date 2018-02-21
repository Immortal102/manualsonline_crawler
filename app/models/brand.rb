class Brand < ApplicationRecord
  has_many :brands_categories, dependent: :destroy
  has_many :categories, through: :brands_categories, dependent: :destroy
  has_many :products, through: :brands_categories, dependent: :destroy
end
