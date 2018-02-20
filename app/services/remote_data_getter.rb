module RemoteDataGetter
  extend ActiveSupport::Concern

  included do
    require 'open-uri'
    require 'nokogiri'

    attr_reader :page

    def errors
      @errors ||= []
    end

    def visit(url)
      @page = Nokogiri::HTML(open(url))
    rescue OpenURI::HTTPError => e
      errors << "Cannot open #{url}. Error: #{e.message}"
    end

    def find_elements(css_selector)
      page.css(css_selector)
    end

    def find_element(css_selector)
      find_elements(css_selector).first
    end
  end
end
