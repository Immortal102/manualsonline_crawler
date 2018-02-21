class Category < ApplicationRecord
  has_many :brands_categories, dependent: :destroy
  has_many :brands, through: :brands_categories
  has_many :products, through: :brands_categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
