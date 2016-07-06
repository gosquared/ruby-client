require './lib/client'

class GoSquared

	class Tracking

		BASEURL = "https://api.gosquared.com/tracking/"
		DIMENSIONS = %w(event identify pageview ping properties timeout transaction)	
		VERSION = %w(v1 v2 v3)

		def initialize(api_key, site_token, client=Client.new)
			@site_token = site_token
			@api_key = api_key
			@client = client
		end

		VERSION.each do |version|
			define_method version do
				@version = version + "/"
				self
			end
		end

		DIMENSIONS.each do |dimension|
			define_method dimension do |options|
				@dimension = dimension 
				@data = options
				self
			end
		end

		def post
			@client.post(url, @data)
		end

		def url
			url = BASEURL + @version + @dimension + "?api_key=#{@api_key}" + "&site_token=#{@site_token}" 
		end

	end
end
