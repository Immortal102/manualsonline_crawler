class Brand < ApplicationRecord
  has_many :brands_categories, dependent: :destroy
  has_many :categories, through: :brands_categories, dependent: :destroy
  has_many :products, through: :brands_categories, dependent: :destroy

  scope :ordered, -> { order('created_at ASC') }

  def empty_category_ids
    category_ids - products.select('DISTINCT brands_categories.category_id as non_empty').map(&:non_empty)
  end
end
