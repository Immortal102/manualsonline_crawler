class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string   :name
      t.string   :manualsonline_subdomain
      t.string   :manualsonline_url
      t.timestamps
    end
  end
end
