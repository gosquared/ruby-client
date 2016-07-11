describe People do
	subject(:gs) { described_class.new("demo", "GSN-106863-S") }
	
	People::DIMENSIONS.each do |dimension|	
		before do 
			data = '{"a": [{"test": "response"}]}'
			stub_request(:get, "https://api.gosquared.com/people/v1/#{dimension}?api_key=demo&site_token=GSN-106863-S" 
				).
			with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
			to_return(status: 200, body: data, headers: {})
		end
	end

	People::DIMENSIONS.each do |dimension|	
		it "fetches a request from the GoSquared People API with #{dimension} dimension" do
			gs.send "#{dimension}"
			expect(gs.fetch).to eq("a" => [{"test"=>"response"}])
		end
	end

	before do 
		data = '{"a": [{"test": "response"}, {"with": "params"}]}'
		stub_request(:get, "https://api.gosquared.com/people/v1/people/example.email@example.com/devices?api_key=demo&site_token=GSN-106863-S").
		with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.gosquared.com', 'User-Agent'=>'Ruby'}).
		to_return(:status => 200, :body => data, :headers => {})
	end

	it "fetches a request from the GoSquared People API with a person_id and paramaters" do
		gs.people.person_id('example.email@example.com','devices')
		expect(gs.fetch).to eq("a" => [{"test"=>"response"}, {"with"=>"params"}])
	end


	People::DIMENSIONS.each do |dimension|	
		before do 
			data = '{"a": [{"test": "response"}, {"with": "params"}]}'
			stub_request(:get, "https://api.gosquared.com/people/v1/#{dimension}?api_key=demo&site_token=GSN-106863-S&limit=5").
			with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.gosquared.com', 'User-Agent'=>'Ruby'}).
			to_return(:status => 200, :body => data, :headers => {})
		end
	end

	GoSquared::People::DIMENSIONS.each do |dimension|
		it "fetches a request from the GoSquared People API with dimension and paramaters" do
			gs.send("#{dimension}").limit(5)
			expect(gs.fetch).to eq("a" => [{"test"=>"response"}, {"with"=>"params"}])
		end
	end


end