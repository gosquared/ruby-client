require_relative "client"

class Gosquared::Account

	BASEURL = "https://api.gosquared.com/account/v1/"
	DIMENSIONS = %w(blocked feeds reportPreferences sharedUsers sites taggedVisitors triggerTypes webhooks)
	DIMENSION_FILTER = %w(token webhookID visitorID triggerType)
	@@filters = {presenter: @presenter, ip: @ip, url: @url, email: @email}

	def initialize(api_key, site_token, client = Client.new)
		@site_token = site_token
		@api_key = api_key
		@client = client
		@bots= ""
		@ips = ""
		@visitor = ""
		@dimension_filter = ""
	end

	DIMENSION_FILTER.each do |filter|
		define_method filter do |parameter = ""|
			@dimension_filter = "/" + parameter
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

	def fetch
		data = @client.get(build_url)
		@@filters.each{|key, value| @@filters[key]=nil} if data
		data
	end

	def post
		response = @client.post(build_url, @data)
		@@filters.each{|key, value| @@filters[key]=nil} if response.code === '200'
		response
	end

	def delete
		response = @client.post(build_url, @data)
		@@filters.each{|key, value| @@filters[key]=nil} if response.code === '200'
		response
	end

	def bots
		@bots = "/bots"
	end

	def ips
		@ips = "/ips"
		self
	end

	def visitors(id="")
		@visitor = "/visitors/#{id}"
		self
	end

	def build_url(ips = @ips)
		array = [""]
		@url = BASEURL + @dimension + @dimension_filter + @visitor + @bots + ips +
		"?api_key=#{@api_key}" + "&site_token=#{@site_token}"
		@@filters.each {|key, value| array << "#{key}=#{value}" if value }
		parameters=array.join('&')
		@url = @url.concat(parameters)
	end

end
