class GoSquared 

	DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screen_dimensions sources transactions)
	VERSION = %w(v1 v2 v3)

	
	def initialize(api_key="demo", site_token="GSN-181546-E")
		@site_token = site_token
		@api_key = api_key
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
		url =  "https://api.gosquared.com/"+@trends+@version+@dimension+"api_key=demo&site_token=GSN-106863-S"
		puts "#{url}"
		uri = URI(url)
		response = Net::HTTP.get(uri)
	end



end