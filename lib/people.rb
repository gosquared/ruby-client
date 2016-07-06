require 'net/https'
require 'uri'
require 'json'

class GoSquared
	class People

		BASEURL = "https://api.gosquared.com/people/"
		VERSION = %w(v1 v2 v3)
		DIMENSIONS = %w(devices event_types people property_types feed smartgroups)
		@@filters = {query: @query, filters: @filters, sort: @sort, 
			format: @presenter, limit: @limit, type: @type, from: @from, to: @to}

			def initialize(api_key, site_token)
				@site_token = site_token
				@api_key = api_key
				@person_id = ""
				@person_filter = ""
			end

			VERSION.each do |version|
				define_method version do 
					@version = version + "/"
					self
				end
			end

			DIMENSIONS.each do |dimension|
				define_method dimension do |options = ""|
					@dimension = dimension 
					@data = options
					self
				end
			end

			@@filters.each do |key, value|
				define_method key do |argument|
					@@filters[key] = argument
					self
				end
			end

			def person_id(object, filter)
				@person_id = "/" + object
				@person_filter = "/" + filter
				self
			end 


			def fetch
				uri = URI(url)
				begin
					response = Net::HTTP.get(uri)
				rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
					Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
					STDERR.puts "[error] HTTP error: #{e}"
				end
				@data = JSON.parse(response)
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
					STDERR.puts "[error] HTTP error: #{e}"
				end
			end

			def url
				array = [""]
				@url = BASEURL + @version + @dimension + @person_id + @person_filter + 
				"?api_key=#{@api_key}" + "&site_token=#{@site_token}"
				@@filters.each { |key, value| array << "#{key}=#{value}" if value }
				parameters=array.join('&')
				@url = @url.concat(parameters)
			end

		end
	end