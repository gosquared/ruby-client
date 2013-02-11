# require_relative 'test_helper'
# require_relative 'support/vcr'
require 'minitest/autorun'

require 'gosquared'

describe GoSquared do
  before do
    @gosquared = GoSquared::API.new(:site_token => "GSN-181546-E", :api_key => "demo")
  end

  describe "concurrents" do
    it "gets concurrents" do
      response = @gosquard.concurrents
      print response
    end
  end
end
