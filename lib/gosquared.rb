require './lib/client'
module GoSquared
  class API < Client
    API_VERSION = ENV.fetch('GOSQUARED_API_VERSION') { "latest" }

    def initialize(opts={})
      super
      debug 2, GoSquared::DEBUG_LEVELS[:WARNING] if @opts[:api_key].nil?
      debug 3, GoSquared::DEBUG_LEVELS[:NOTICE], {:api_version => API_VERSION} if @opts[:api_version].nil?

      @req_opts[:api_key] = @opts[:api_key]
      @opts[:api_version] ||= API_VERSION
    end

    def url
      @url ||= GoSquared::API_ENDPOINT + '/' + @opts[:api_version]
    end

    GoSquared::API_FUNCTIONS.each do | func_name |
      class_eval %{
        def #{func_name}(func_params={})
          get("/#{func_name}")
        end
      }
    end
  end

  class Event < Client

    def initialize(opts={})
      super
    end

    def url
      @url ||= GoSquared::EVENT_ENDPOINT
    end

    def store_event(name, params={})
      debug 4, GoSquared::DEBUG_LEVELS[:WARNING] if name.nil?

      params = JSON.generate(params)
      query_params = {
        :_name => name
      }
      post('/event', query_params, params)
    end
  end

end
