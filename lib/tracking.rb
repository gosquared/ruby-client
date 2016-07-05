require 'net/https'
require 'uri'
require 'json'

class GoSquared

	class Tracking

		BASEURL = "https://api.gosquared.com/tracking/"
		DIMENSIONS = %w(event identify pageview ping properties timeout transaction)	
		VERSION = %w(v1 v2 v3)

		def initialize(api_key="1F6DLEGZKZ2QUK48", site_token="GSN-086224-W")
			@site_token = site_token
			@api_key = api_key
		end

		DIMENSIONS.each do |dimension|
			define_method dimension do |options|
				@dimension = dimension + "?"
				@data = options
				self
			end
		end

		VERSION.each do |version|
			define_method version do
				@version = version + "/"
				self
			end
		end

		def post
			uri = URI.parse(url)
			begin
				https = Net::HTTP.new(uri.host, uri.port)
				https.use_ssl = true
				request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
				request.body = "[ #{@data.to_json} ]"
				response = https.request(request)
			rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
				Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
				puts "[error] HTTP error: #{e}"
			end
			puts "Response #{response.code} #{response.message}: #{response.body}"
		end

		def url
			@url = BASEURL + @version + @dimension + "api_key=#{@api_key}" + "&site_token=#{@site_token}" 
		end

	end
end
