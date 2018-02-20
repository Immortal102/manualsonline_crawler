class CategoriesService < StartDataService
  CONFIG_PATH = "#{Rails.root.to_s}/config/product_types.yml"

  def get_data
    binding.pry
  end
end
