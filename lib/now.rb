class GoSquared
	class Now

		BASEURL = "https://api.gosquared.com/now/"

		VERSION = %w(v1 v2 v3)
		DIMENSIONS = %w(browsers campaigns concurrents engagement geo languages notifications 
								organisations overview pages platforms sources time time_series visitors)

		def initialize(api_key="demo", site_token="GSN-2194840-F")
		@site_token = site_token
		@api_key = api_key
		@filters = {dateFormat: @date_format, from: @from, to: @to, 
								format: @format, limit: @limit, sort: @sort, 
								presenter: @presenter, visitors_mode: @string, href: @href, 
								drill_limit: @drill_limit, sections: @sections,
								minimal: @minimal, interval: @interval}
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

		def fetch
			build_url
			uri = URI(@url)
			response = Net::HTTP.get(uri)
			@data = JSON.parse(response)
		end

		def build_url
			array = [""]
			@url = BASEURL + @version + @dimension + "api_key=#{@api_key}" + "&site_token=#{@site_token}"
			@filters.each {|key, value| array << "#{key}=#{value}" if value }
			parameters=array.join('&')
			@url = @url.concat(parameters)
		end


	end
end