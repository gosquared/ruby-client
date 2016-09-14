module Gosquared

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    block_given? ? yield(configuration) : configuration
  end

  class Configuration
    attr_accessor :site_token
  end

end
