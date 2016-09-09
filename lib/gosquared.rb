require 'tracker_inject/railtie' if defined? (Rails)
require_relative "gosquared/trends"
require_relative "gosquared/tracking"
require_relative "gosquared/people"
require_relative "gosquared/now"
require_relative "gosquared/account"
require_relative "config"

module GoSquared

	class RubyLibrary

		def initialize api_key, site_id
			@api_key = api_key
			@site_id = site_id
		raise 'api key cannot be empty/nil' if api_key.nil? || api_key.empty?
    raise 'site_token cannot be empty/nil' if site_id.nil? || site_id.empty?
		end

		def trends
			@trends ||= Trends.new(@api_key, @site_id)
		end

		def tracking
			@tracking ||= Tracking.new(@api_key, @site_id)
		end

		def people
			@people ||=  People.new(@api_key, @site_id)
		end

		def now
			@now ||= Now.new(@api_key, @site_id)
		end

		def account
			@account ||= Account.new(@api_key, @site_id)
		end

	end

end
