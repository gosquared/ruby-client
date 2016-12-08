require_relative "client"

module Gosquared
  class People

  	BASEURL = "https://api.gosquared.com/people/v1/"
  	VERSION = %w(v1 v2 v3)
  	DIMENSIONS = %w(devices eventTypes people propertyTypes feed smartgroups)
  	@@filters = {query: @query, filters: @filters, sort: @sort,
  		format: @presenter, limit: @limit, type: @type, from: @from, to: @to}

  		def initialize(api_key, site_token, client =Client.new)
  			@site_token = site_token
  			@api_key = api_key
  			@person_id = ""
  			@person_filter = ""
  			@client = client
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
  			data = @client.get(url)
  			@@filters.each{|key, value| @@filters[key]=nil} if data
  			data
  		end

  		def url
  			array = [""]
  			url = BASEURL + @dimension + @person_id + @person_filter +
  			"?api_key=#{@api_key}" + "&site_token=#{@site_token}"
  			@@filters.each { |key, value| array << "#{key}=#{value}" if value }
  			parameters=array.join('&')
  			url.concat(parameters)
  		end

  	end
end
