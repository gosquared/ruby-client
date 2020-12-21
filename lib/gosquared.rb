require_relative 'gosquared/trends'
require_relative 'gosquared/tracking'
require_relative 'gosquared/people'
require_relative 'gosquared/now'
require_relative 'gosquared/account'

module Gosquared
  VERSION = '3.1.0'.freeze

  class RubyLibrary
    def initialize(api_key, site_id)
      @api_key = api_key
      @site_id = site_id
      raise 'api key cannot be empty/nil' if api_key.nil? || api_key.empty?
      raise 'site_token cannot be empty/nil' if site_id.nil? || site_id.empty?
    end

    def trends
      @trends ||= Gosquared::Trends.new(@api_key, @site_id)
    end

    def tracking
      @tracking ||= Gosquared::Tracking.new(@api_key, @site_id)
    end

    def people
      @people ||= Gosquared::People.new(@api_key, @site_id)
    end

    def now
      @now ||= Gosquared::Now.new(@api_key, @site_id)
    end

    def account
      @account ||= Gosquared::Account.new(@api_key, @site_id)
    end
  end
end

module GoSquared
  include Gosquared
end
