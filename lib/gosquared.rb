require './lib/trends'
require './lib/tracking'
require './lib/people'
require './lib/now'
require './lib/account'

class GoSquared 

	def initialize api_key, site_id
		@api_key = api_key
		@site_id = site_id
	end

	def trends
		@trends ||= GoSquared::Trends.new(@api_key, @site_id)
	end

	def tracking 
		@tracking ||= GoSquared::Tracking.new(@api_key, @site_id)
	end

	def people 
		@people ||=  GoSquared::People.new(@api_key, @site_id)
	end

	def now 
		@now ||= GoSquared::Now.new(@api_key, @site_id)
	end

	def account 
		@account ||= Account.new(@api_key, @site_id)
	end

end