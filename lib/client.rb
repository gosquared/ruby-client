module GoSquared
  class Client
    attr_accessor :url
    API_KEY = ENV.fetch('GOSQUARED_API_KEY') { "demo" }

    Error = Class.new(StandardError)

    def RESTClient
      return @RESTClient if @RESTClient

      @RESTClient = Faraday.new(
        :url    => @url,
        :params => @params
      )
    end

    def get(path, params={})
      response = @RESTClient.get(path, params)
      raise Error, parse(response.body) unless response.status.to_s.start_with?("20")
      parse(response.body)
    end

    def parse(content)
      JSON.parse(content)
    end
  end
end
