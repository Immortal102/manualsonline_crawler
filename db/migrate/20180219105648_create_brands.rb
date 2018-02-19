class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :manualsonline_url
      t.timestamps
    end
  end
end
