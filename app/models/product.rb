class Product < ApplicationRecord
  belongs_to :brands_category
  has_one :category, through: :brands_category
  has_one :brand, through: :brands_category

  scope :for_categories, ->(c_ids) { joins(:brands_category).where("brands_categories.category_id IN (?)", Array.wrap(c_ids)) }
  scope :for_brands, ->(b_ids) { joins(:brands_category).where("brands_categories.brand_id IN (?)", Array.wrap(b_ids)) }
end
