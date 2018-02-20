class CategoriesService < StartDataService
  CONFIG_PATH = "#{Rails.root.to_s}/config/product_types.yml"

  def initialize(brand, use_matching=true)
    @brand = brand
    @use_mathing = use_matching
    super()
  end

  def populate_db!
    prepared_to_insert.each do |attrs|
      ActiveRecord::Base.transaction do
        cat = Category.find_or_create_by!(attrs[:c_data])
        BrandsCategory.create!(attrs[:bc_data].merge(category_id: cat.id))
      end
    rescue Exception => e
      @errors << {name: "brand: '#{@brand.name}'' / category: '#{attrs[:c_data]}'", errs: e.message}
    end
  end

  def prepared_to_insert
    @prepared_to_insert ||= begin
      brand_categories.map do |raw_data|
        prepared_from_raw(raw_data)
      end.compact
    end
  end

  def errors
    @errors.concat(remote_data_getter.errors)
  end

  private
  def brand_categories
    remote_data_getter.get_categories_data
  end

  def remote_data_getter
    @remote_data_getter ||= ManualsonlineDataService.new(@brand.manualsonline_url)
  end

  def prepared_from_raw(data)
    c_name = data[:link_text].gsub(/\sManuals/, '').downcase
    return if (@use_mathing && !matched.find{|md| md.downcase == c_name})
    uri = URI(data[:href])
    subdomain = uri.host.gsub(/www\./, '').split('.').first
    {
      c_data: { name: c_name, manualsonline_subdomain: subdomain },
      bc_data: { manualsonline_url: uri.to_s, brand_id: @brand.id }
    }
  end
end
