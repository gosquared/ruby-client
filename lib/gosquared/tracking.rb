require './lib/gosquared/client'
	class Tracking

		BASEURL = "https://api.gosquared.com/tracking/v1/"
		DIMENSIONS = %w(event identify pageview ping properties timeout transaction)	

		def initialize(api_key, site_token, client=Client.new)
			@site_token = site_token
			@api_key = api_key
			@client = client
		end

		DIMENSIONS.each do |dimension|
			define_method dimension do |options|
				@dimension = dimension 
				@data = options
				self
			end
		end

		def post
			response = @client.post(url, @data)
			@data = nil if response.code === '200'
			response
		end

		def url
			url = BASEURL + @dimension + "?api_key=#{@api_key}" + "&site_token=#{@site_token}" 
		end

	end