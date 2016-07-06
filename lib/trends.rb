require './lib/client'

class GoSquared 

	class Trends

		BASEURL = "https://api.gosquared.com/trends/"
		DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screen_dimensions sources transactions)
		VERSION = %w(v1 v2 v3)
		@@filters = {date_format: @date_format, from: @from, to: @to, 
			format: @format, limit: @limit, sort: @sort, group: @group}

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
				define_method dimension do
					@dimension = dimension 
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
				url = BASEURL + @version + @dimension + "?api_key=#{@api_key}" + "&site_token=#{@site_token}"
				@@filters.each {|key, value| array << "#{key}=#{value}" if value }
				parameters=array.join('&')
				url.concat(parameters)
			end
		end

	end