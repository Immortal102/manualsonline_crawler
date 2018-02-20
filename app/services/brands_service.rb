class BrandsService < StartDataService
  CONFIG_PATH = "#{Rails.root.to_s}/config/brands.yml"

  def initialize(remote=false)
    @remote = remote ? 'remote' : 'local'
    super()
  end

  def prepared_to_insert
    @prepared_to_insert ||= generate_method(__method__)
  end

  def populate_db!
    prepared_to_insert.each do |attrs|
      Brand.create! attrs
    rescue Exception => e
      @errors << {name: attr[:name], errs: e.message}
    end
  end

  def errors
    @errors.concat(remote_data_getter.errors)
  end

  private
  def generate_method(prefix)
    send("#{prefix}_#{@remote}")
  end

  def prepared_to_insert_local
    # get matched brands with the urls from brands.yml
    matched.map { |mb_name| { name: mb_name, manualsonline_url: url_for(allowed.find{|a| a[:name] == mb_name}[:slug]) }}
  end

  def prepared_to_insert_remote
    # get all the brands with the urls from http://manualsonline.com/brands/
    remote_data_getter.get_brands_data.map do |raw_data|
      prepared_from_raw(raw_data)
    end
  end

  def prepared_from_raw(data)
    base_uri = URI(base_url)
    b_name = data[:link_text]
    uri = URI(data[:href])

    uri.scheme = base_uri.scheme
    uri.host = base_uri.host

    { name: b_name, manualsonline_url: uri.to_s }
  end

  def remote_data_getter
    @remote_data_getter ||= ManualsonlineDataService.new(base_url)
  end

  def url_for(slug)
    base_url + '/' + slug
  end
end
