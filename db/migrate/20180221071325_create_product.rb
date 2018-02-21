class CreateProduct < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :brands_category_id
      t.string  :raw_name
      t.string  :name
      t.string  :manualsonline_url
      t.timestamps
    end
  end
end
