class ProductsService
  def initialize(brand, category)
    @brand = brand
    @category = category
    @brands_category = BrandsCategory.find_by(brand_id: @brand.id, category_id: @category.id)
    @errors = []
  end

  def populate_db!
    prepared_to_insert.each do |attrs|
      Product.create!(attrs)
    rescue Exception => e
      @errors << {name: "brand: '#{@brand.name}' / category: '#{@category.name}' / product: '#{attrs[:name]}'", errs: e.message}
    end
  end

  def prepared_to_insert
    @prepared_to_insert ||= begin
      brands_category_products.map do |raw_data|
        prepared_from_raw(raw_data)
      end
    end
  end

  def errors
    @errors.concat(remote_data_getter.errors)
  end

  private
  def brands_category_products
    remote_data_getter.get_products_data
  end

  def remote_data_getter
    @remote_data_getter ||= ManualsonlineDataService.new(@brands_category.manualsonline_url)
  end

  def prepared_from_raw(data)
    base_uri = URI(@brands_category.manualsonline_url)
    b_name = data[:link_text].gsub(Regexp.new("#{@brand.name} #{@category.name}", Regexp::IGNORECASE), '').strip
    uri = URI(data[:href])

    uri.scheme = base_uri.scheme
    uri.host = base_uri.host

    { raw_name: data[:link_text], name: b_name, manualsonline_url: uri.to_s, brands_category_id: @brands_category.id }
  end
end
