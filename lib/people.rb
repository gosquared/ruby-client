class GoSquared
	class People

		BASEURL = "https://api.gosquared.com/people/"
		VERSION = %w(v1 v2 v3)
		DIMENSIONS = %w(devices event_types people property_types smartgroups)

		def initialize(api_key="demo", site_token="GSN-106863-S")
			@site_token = site_token
			@api_key = api_key
			@filters = {query: @query, filters: @filters, sort: @sort, 
				format: @presenter, limit: @limit}
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
				puts "#{@url}"
			end

			def query(string) 	
				@filters['query']=query
				self
			end

			def filters(array) 	
				@filters['filters']=array
				self
			end

			def sort(by) 	
				@filters['sort']=by
				self
			end

			def limit(number)
				@filters['limit']=number
				self
			end

			def presenter(string)
				@filters['presenter']=string
				self
			end

		end
	end
