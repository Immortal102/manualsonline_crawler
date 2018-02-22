class AddNeededIndexes < ActiveRecord::Migration[5.1]
  def change
    add_index :brands, [:name]
    add_index :brands_categories, [:brand_id, :category_id]
    add_index :categories, [:name, :manualsonline_subdomain]
    add_index :products, [:brands_category_id, :name, :raw_name]
  end
end
