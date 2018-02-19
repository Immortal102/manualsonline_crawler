class Category < ApplicationRecord
  has_many :brands_categories, dependent: :destroy
  has_many :brands, through: :brands_categories, dependent: :destroy
end
