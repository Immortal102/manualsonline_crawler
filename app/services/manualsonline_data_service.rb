class ManualsonlineDataService
  include RemoteDataGetter
  attr_accessor :products_data, :categories_data

  def initialize(page_url)
    @products_data = @categories_data = []
    @uri = URI(page_url)
  end

  def get_categories_data
    get_links_data('.letter-content .seeprices-header > a', categories_data)
  end

  def get_products_data
    get_links_data('.product-list h5 > a', products_data)
  end

  private
  def next_page
    current_pag_el = find_element('.pagination .step-links .current')
    return unless next_page = current_pag_el && current_pag_el.next_element
    np_uri = URI(next_page[:href])
    np_uri.scheme = @uri.scheme
    np_uri.host = @uri.host
    np_uri
  end

  def with_pagination(&block)
    begin
      block.call
      @uri = next_page
    end while next_page.present?
  end

  def get_links_data(selector, container)
    with_pagination do
      visit(@uri.to_s)
      find_elements(selector).each do |el|
        container << { link_text: el.text, href: el[:href] }
      end
    end

    container
  end
end
