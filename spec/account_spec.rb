describe GoSquared::Account do
	subject(:gs) { described_class.new() }

	before do 
		GoSquared::Account::DIMENSIONS.each do |dimension|	
			data = '{"a": [{"test": "response"}]}'
			stub_request(:get, "https://api.gosquared.com/account/v1/#{dimension}?api_key=demo&site_token=GSN-2194840-F" ).
			with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
			to_return(status: 200, body: data, headers: {})
		end
	end

	GoSquared::Account::DIMENSIONS.each do |dimension|	
		it "fetches a request from the GoSquared Account API with #{dimension} dimension"  do 
			gs.v1.send("#{dimension}")
			expect(gs.fetch).to eq("a" => [{"test"=>"response"}])
		end
	end

	before do 
		stub_request(:post, "https://api.gosquared.com/account/v1/blocked/ips?api_key=demo&site_token=GSN-2194840-F&ip=20.15.33.99").
		with(:body => "[ null ]",
			:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
		to_return(:status => 200, :body => "", :headers => {})
	end

	it "posts a request to the GoSquared Account API with an IP address to block bots"  do 
		gs.v1.blocked.address.ip('20.15.33.99')
		expect(gs.post.code).to eq('200')
	end

	before do 
		data = '{"a": [{"test": "response"}]}'
		stub_request(:get, "https://api.gosquared.com/account/v1/blocked/visitors/test.email@gmail.com?api_key=demo&ip=20.15.33.99&site_token=GSN-2194840-F").
		with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.gosquared.com', 'User-Agent'=>'Ruby'}).
		to_return(:status => 200, :body => data, :headers => {})
	end

	it "retrieves a list of blocked visitors"  do 
		gs.v1.blocked.visitors("test.email@gmail.com")
		expect(gs.fetch).to eq("a" => [{"test"=>"response"}])
	end

end