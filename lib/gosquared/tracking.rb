require_relative "client"

module Gosquared
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
  		check_for_nil_user
  		response = @client.post(url, @data)
  		@data = nil if response.code === '200'
  		response
  	end

  	def url
  		url = BASEURL + @dimension + "?api_key=#{@api_key}" + "&site_token=#{@site_token}"
  	end

  	private

  	def check_for_nil_user
  		if @data.key?(:person_id) && @data[:person_id] == nil
  			@data.tap { |data| @data.delete(:person_id) }
  			warn 'person_id is nil, event will not be track against a user'
  		end
  	end

  end
end
