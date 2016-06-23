class GoSquared 

	DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screen_dimensions sources transactions)

		DIMENSIONS.each do |dimension|
			define_method dimension do
				@dimension = dimension + "?"
				self
			end
		end

	def trends
		@trends = 'trends/'
		self
	end

	def v2
		@v2 = 'v2/'
		self
	end

	def fetch
		url =  "https://api.gosquared.com/"+@trends+@v2+@dimension
		puts "#{url}"
		uri = URI(url)
		response = Net::HTTP.get(uri)
	end

end