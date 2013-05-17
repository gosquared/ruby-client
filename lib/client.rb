require 'json'
require 'faraday'
require 'uri'
require_relative '../config/default'

module GoSquared
  class Client
    @@opts = {}
    Error = Class.new(StandardError)

    def initialize(opts={})
      @opts = @@opts.merge(opts)
      debug 1, GoSquared::DEBUG_WARNING if opts[:site_token].nil?
      @opts[:debugLevel] ||= GoSquared::DEBUG_DEFAULT_LEVEL

      @req_opts = {
        :site_token  => opts[:site_token]
      }
    end

    def RESTClient
      @RESTClient ||= Faraday.new(:url => @url)
    end

    def get(path, query_params={})
      response = RESTClient().get do | req |
        req.url url + path
        req.params = @req_opts.merge(query_params)
      end
      return false unless response.status.to_s.start_with?("20")
      parse(response.body)
    end

    def post(path, query_params, post_body="")
      response = RESTClient().post do | req |
        req.url url + path
        req.headers['Content-Type'] = 'application/json'
        req.params = @req_opts.merge(query_params)
        req.body = post_body
      end
      return false unless response.status.to_s.start_with?("20")
      parse(response.body)
    end

    def parse(content)
      JSON.parse(content)
    end

    def debug(code, level, extra)
      return true if (@opts[:debugLevel] & level).zero?

      stream = level > GoSquared::DEBUG_LEVELS[:NOTICE] ? $stdout : $stderr

      # Errors are machine-parseable
      stream.printf "[GoSquared][%s]:%s\n", level, JSON.generate({message: GoSquared::DEBUG_CODES[code], code: code, extra: extra})
    end
  end
end
