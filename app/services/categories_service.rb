class CategoriesService < StartDataService
  CONFIG_PATH = "#{Rails.root.to_s}/config/product_types.yml"
  attr_reader :allowed, :given, :matching

  def self.config_data
    @conf_data ||= YAML.load_file(CONFIG_PATH).with_indifferent_access
  end

  def initialize
    @allowed = self.class.config_data[:all]
    @given = self.class.config_data[:given]
    @matching = self.class.config_data[:matching]
  end

  def matched
    @matched ||= given.map{ |g| matching[g] || g }.flatten
  end

  def missed
    @missed ||= matched - allowed
  end

  def get_data
    binding.pry
  end
end
