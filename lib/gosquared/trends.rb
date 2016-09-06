require_relative "client"
	class Trends

		BASEURL = "https://api.gosquared.com/trends/v2/"
		DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screenDimensions sources transactions)
		@@filters = {date_format: @date_format, from: @from, to: @to,
			format: @format, limit: @limit, sort: @sort, group: @group}

			def initialize(api_key, site_token, client=Client.new)
				@site_token = site_token
				@api_key = api_key
				@client = client
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
				data = @client.get(url)
				@@filters.each{|key, value| @@filters[key]=nil} if data
				data
			end

			private

			def url
				array = [""]
				url = BASEURL + @dimension + "?api_key=#{@api_key}" + "&site_token=#{@site_token}"
				@@filters.each {|key, value| array << "#{key}=#{value}" if value }
				parameters=array.join('&')
				url.concat(parameters)
			end
		end
