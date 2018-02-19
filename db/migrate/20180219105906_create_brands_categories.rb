class CreateBrandsCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :brands_categories do |t|
      t.integer :brand_id, null: false
      t.integer :category_id, null: false
      t.string  :manualsonline_url
      t.timestamps
    end
  end
end
