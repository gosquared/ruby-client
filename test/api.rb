require 'minitest/autorun'

require 'gosquared'

describe GoSquared do
  before do
    @gosquared = GoSquared::API.new({:site_token => "GSN-106863-S", :api_key => "demo"})
  end

  describe "getting functions" do
    GoSquared::API_FUNCTIONS.each do | func_name |
      it "gets #{func_name}" do
        response = @gosquared.send(func_name)
      end
    end
  end
end
