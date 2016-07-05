class GoSquared
	class Now

		BASEURL = "https://api.gosquared.com/now/"

		VERSION = %w(v1 v2 v3)
		DIMENSIONS = %w(browsers campaigns concurrents engagement geo languages notifications 
			organisations overview pages platforms sources time time_series visitors)
		@@filters = {dateFormat: @date_format, from: @from, to: @to, 
			format: @format, limit: @limit, sort: @sort, 
			presenter: @presenter, visitors_mode: @string, href: @href, 
			drill_limit: @drill_limit, sections: @sections,
			minimal: @minimal, interval: @interval}

	def initialize(api_key="demo", site_token="GSN-2194840-F")
		@site_token = site_token
		@api_key = api_key
	end

	VERSION.each do |version|
		define_method version do
			@version = version + "/"
			self
		end
	end

	DIMENSIONS.each do |dimension|
		define_method dimension do
			@dimension = dimension + "?"
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
		build_url
		uri = URI(@url)
		begin
			response = Net::HTTP.get(uri)
		rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
			Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
			puts "[error] HTTP error: #{e}"
		end
		@data = JSON.parse(response)
	end

	private

	def build_url
		array = [""]
		@url = BASEURL + @version + @dimension + "api_key=#{@api_key}" + "&site_token=#{@site_token}"
		@@filters.each {|key, value| array << "#{key}=#{value}" if value }
		parameters=array.join('&')
		@url = @url.concat(parameters)
	end

end
end