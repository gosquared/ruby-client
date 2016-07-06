require './lib/client'

class GoSquared
	class Now

		BASEURL = "https://api.gosquared.com/now/v3/"
		DIMENSIONS = %w(browsers campaigns concurrents engagement geo languages notifications 
			organisations overview pages platforms sources time time_series visitors)
	@@filters = {dateFormat: @date_format, from: @from, to: @to, 
	format: @format, limit: @limit, sort: @sort, 
	presenter: @presenter, visitors_mode: @string, href: @href, 
	drill_limit: @drill_limit, sections: @sections,
	minimal: @minimal, interval: @interval}

	def initialize(api_key, site_token, client=Client.new)
		@site_token = site_token
		@api_key = api_key
		@client = client
	end


	DIMENSIONS.each do |dimension|
		define_method dimension do
			@@dimension = dimension 
			self
		end
	end	

	@@filters.each do |key, value|
		define_method key do |argument|
			@@filters[key] = argument
			self
		end
	end

	def fetch
		@client.get(url)
	end
	
	private

	def url
		array = [""]
		@url = BASEURL + @@dimension + "?api_key=#{@api_key}" + "&site_token=#{@site_token}"
		@@filters.each {|key, value| array << "#{key}=#{value}" if value }
		parameters=array.join('&')
		@url = @url.concat(parameters)
	end

end
end