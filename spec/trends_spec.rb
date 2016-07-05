describe GoSquared::Trends do 
	subject(:gs) { described_class.new() }

	GoSquared::Trends::DIMENSIONS.each do |dimension|
		it { is_expected.to respond_to(dimension) }  
	end

	GoSquared::Trends::VERSION.each do |version|
		it { is_expected.to respond_to(version) }  
	end

	before do 
		GoSquared::Trends::DIMENSIONS.each do |dimension|	
			data = '{"a": [{"test": "response"}]}'
			stub_request(:get, "https://api.gosquared.com/trends/v2/#{dimension}?api_key=demo&site_token=GSN-106863-S").
			with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
			to_return(status: 200, body: data, headers: {})
		end
	end

	GoSquared::Trends::DIMENSIONS.each do |dimension|	
		it "fetches a request from the GoSquared Trends API with #{dimension} dimension" do
			gs.trends.v2.send "#{dimension}"
			expect(gs.fetch).to eq("a" => [{"test"=>"response"}])
		end
	end

	before do 
		GoSquared::Trends::DIMENSIONS.each do |dimension|	
			data = '{"a": [{"test": "response"}, {"with": "params"}]}'
			stub_request(:get, "https://api.gosquared.com/trends/v2/#{dimension}?api_key=demo&site_token=GSN-106863-S&date_format=yyyy-mm-dd&format=json&from=2016-06-20&group=true&limit=5&site_token=GSN-106863-S&sort=visits&to=2016-06-30").
			with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.gosquared.com', 'User-Agent'=>'Ruby'}).
			to_return(:status => 200, :body => data, :headers => {})
		end
	end

GoSquared::Trends::DIMENSIONS.each do |dimension|	
	it "fetches a request from the GoSquared Trends API with #{dimension} dimension and paramaters" do
	gs.trends.v2.send("#{dimension}").from('2016-06-20').to('2016-06-30')
	.date_format('yyyy-mm-dd').sort('visits').group(true).format('json').limit(5)
	expect(gs.fetch).to eq("a" => [{"test"=>"response"}, {"with"=>"params"}])
end
end

end