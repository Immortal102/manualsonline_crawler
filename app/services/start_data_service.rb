class StartDataService
  attr_reader :base_url, :allowed, :given, :matching

  def self.config_data
    if defined?(self::CONFIG_PATH)
      @conf_data ||= YAML.load_file(self::CONFIG_PATH).with_indifferent_access
    else
      fail 'You are trying to use the abstract class'
    end
  end

  def initialize
    @base_url = self.class.config_data[:base_url]
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
end
