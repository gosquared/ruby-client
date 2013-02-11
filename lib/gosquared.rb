require 'json'
require 'faraday'
require 'uri'
require 'pry'
require_relative './client'
require_relative '../config/default'

module GoSquared
  class API < Client
    @url = GoSquared::API_ENDPOINT
    API_VERSION = "latest"
    API_KEY = ENV.fetch('GOSQUARED_API_KEY') { "demo" }

    Error = Class.new(StandardError)

    def initialize(params={})
      @params = {
        :api_version => API_VERSION,
        :api_key     => API_KEY
      }.merge(params)
      @url = GoSquared::API_ENDPOINT + '/' + @params[:api_version]
    end

    def concurrents(params={})
      get('/concurrents');
    end

  end

  class Event < Client
    @url = GoSquared::EVENT_ENDPOINT


  end

end
