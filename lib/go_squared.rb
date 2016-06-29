class GoSquared 

	BASEURL = "https://api.gosquared.com/"
	DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screen_dimensions sources transactions)
	VERSION = %w(v1 v2 v3)

	def initialize(api_key="demo", site_token="GSN-106863-S")
		@site_token = site_token
		@api_key = api_key
		@filters = {dateFormat: @date_format, from: @from, to: @to, 
			format: @format, limit: @limit, sort: @sort, group: @group}
		end

		DIMENSIONS.each do |dimension|
			define_method dimension do
				@dimension = dimension + "?"
				self
			end
		end	

		VERSION.each do |version|
			define_method version do
				@version = version + "/"
				self
			end
		end

		def trends
			@trends = 'trends/'
			self
		end

		def fetch
			build_url
			puts "#{@url}"
			uri = URI(@url)
			response = Net::HTTP.get(uri)
		end

		def build_url
			array = [""]
			@url = BASEURL + @trends + @version + @dimension + "api_key=#{@api_key}" + "&site_token=#{@site_token}"
			@filters.each {|key, value| array << "#{key}=#{value}" if value }
			parameters=array.join('&')
			@url = @url.concat(parameters)
		end

		def from(date) 	
			@filters['from']=date
			self
		end

		def to(date) 	
			@filters['to']=date
			self
		end

		def date_format(format) 	
			@filters['date_format']=format
			self
		end

		def sort(by) 	
			@filters['sort']=by
			self
		end

		def group(by)
			@filters['group']=by
			self
		end

		def form(type)
			@filters['format']=type
			self
		end

		def limit(number)
			@filters['limit']=number
			self
		end


	end