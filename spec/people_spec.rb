describe GoSquared::People do
	subject(:gs) { described_class.new() }
	
	before do 
		data = '{"a": [{"test": "response"}]}'
		stub_request(:get, "https://api.gosquared.com/people/v1/devices?api_key=demo&site_token=GSN-106863-S" 
			).
		with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
		to_return(status: 200, body: data, headers: {})
	end

	it "fetches a request from the GoSquared People API " do
		gs.people.v1.devices
		expect(gs.fetch).to eq("a" => [{"test"=>"response"}])
	end


	before do 
			data = '{"a": [{"test": "response"}, {"with": "params"}]}'
			stub_request(:get, "https://api.gosquared.com/people/v1/people?api_key=demo&site_token=GSN-106863-S&limit=5").
			with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.gosquared.com', 'User-Agent'=>'Ruby'}).
			to_return(:status => 200, :body => data, :headers => {})
	end


	it "fetches a request from the GoSquared People API with dimension and paramaters" do
	gs.people.v1.people.limit(5)
	expect(gs.fetch).to eq("a" => [{"test"=>"response"}, {"with"=>"params"}])
end

end