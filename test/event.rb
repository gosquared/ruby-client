require 'minitest/autorun'

require 'gosquared'

describe GoSquared do
  before do
    @gosquared = GoSquared::Event.new(:site_token => "GSN-106863-S")
  end

  describe "storing events" do
    it "stores an event with name and parameters" do
      response = @gosquared.store_event "Test Event", {:random => "params", :cause => "I can"}
    end

    it "stores an event with name and without parameters" do
      response = @gosquared.store_event "Test Event"
    end
  end
end
