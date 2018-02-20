class BrandsService < StartDataService
  CONFIG_PATH = "#{Rails.root.to_s}/config/brands.yml"

  def prepared_to_insert
    @prepared_to_insert ||= begin
      matched.map { |mb_name| { name: mb_name, manualsonline_url: url_for(mb_name) } }
    end
  end

  def populate_db!
    prepared_to_insert.each do |attrs|
      Brand.create! attrs
    rescue Exception => e
      @errors << {name: attr[:name], errs: e.message}
    end
  end

  private
  def url_for(brand_name)
    base_url + '/' + brand_name.strip.gsub(/\s/, '_').gsub(/-/, '').downcase
  end
end
