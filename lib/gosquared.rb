require './lib/trends'
require './lib/tracking'
require './lib/people'
require './lib/now'

class GoSquared 

	def initialize api_key, site_id
		@api_key = api_key
		@site_id = site_id
	end

	def trends
	GoSquared::Trends.new(@api_key, @site_id)
	end

	def tracking 
	GoSquared::Tracking.new(@api_key, @site_id)
	end

	def people 
	GoSquared::People.new(@api_key, @site_id)
	end

	def now 
	GoSquared::Now.new(@api_key, @site_id)
	end

end