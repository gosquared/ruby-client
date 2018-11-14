require_relative 'client'

module Gosquared
  class People
    BASEURL = 'https://api.gosquared.com/people/v1/'.freeze
    VERSION = %w[v1 v2 v3].freeze
    DIMENSIONS = %w[devices eventTypes people propertyTypes feed].freeze
    @@filters = { query: @query, filters: @filters, sort: @sort,
                  format: @presenter, limit: @limit, type: @type, from: @from, to: @to }

    def initialize(api_key, site_token)
      @site_token = site_token
      @api_key = api_key
      @person_id = ''
      @person_filter = ''
   end

    DIMENSIONS.each do |dimension|
      define_method dimension do |options = ''|
        @dimension = dimension
        @data = options
        self
      end
    end

    @@filters.each do |key, _value|
      define_method key do |argument|
        @@filters[key] = argument
        self
      end
    end

    def person_id(object, filter=nil)
      @person_id = '/' + object
      @person_filter = '/' + filter if filter
      self
   end

    def smartgroups(group_id = nil, filter = nil)
      if group_id
        @dimension = "smartgroups/#{group_id}/people" if filter == 'people'
        @dimension = "smartgroups/#{group_id}/count/latest" if filter == 'count'
      else @dimension = 'smartgroups'
      end
      self
    end

    def fetch
      data = Client.new.get(url)
      @@filters.each { |key, _value| @@filters[key] = nil } if data
      data
    end

    def delete
      response = Client.new.delete(url)
    end

    def url
      array = ['']
      url = BASEURL + @dimension + @person_id + @person_filter +
            "?api_key=#{@api_key}" + "&site_token=#{@site_token}"
      @@filters.each do |key, value|
        if @dimension == 'people' && key == :filters && value.is_a?(Array)
          json_object = JSON.generate(value)
          filter_request = URI.escape(json_object, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
          array << "#{key}=#{filter_request}"
        else
          array << "#{key}=#{value}" if value
        end
      end
      parameters = array.join('&')
      url.concat(parameters)
   end

    def post
      check_for_nil_user
      response = Client.new.post(url, @data)
      @data = nil if response.code === '200'
      response
    end

    def check_for_nil_user
      if @data.key?(:person_id) && @data[:person_id].nil?
        @data.tap { |_data| @data.delete(:person_id) }
        warn 'person_id is nil, event will not be track against a user'
      end
    end
  end
end
