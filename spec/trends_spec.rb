describe GoSquared::Trends do 
	subject(:gs) { described_class.new() }

	GoSquared::Trends::DIMENSIONS.each do |dimension|
		it { is_expected.to respond_to(dimension) }  
	end

	GoSquared::Trends::VERSION.each do |version|
		it { is_expected.to respond_to(version) }  
	end


it 'fetches a request from the GoSquared Trends API'do
	data = '{"a": [{"test": "response"}]}'
	stub_request(:get, 'https://api.gosquared.com/trends/v2/aggregate?api_key=demo&site_token=GSN-106863-S').
	with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
	to_return(status: 200, body: data, headers: {})
	gs.trends.v2.aggregate
	expect(gs.fetch).to eq("a" => [{"test"=>"response"}])
end

it 'fetches a request from the GoSquared Trends API with paramaters'do
data = '{"a": [{"test": "response"}, {"with": "params"}]}'
stub_request(:get, "https://api.gosquared.com/trends/v2/browser?api_key=demo&date_format=yyyy-mm-dd&format=json&from=2016-06-20&group=true&limit=5&site_token=GSN-106863-S&sort=visits&to=2016-06-30").
with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.gosquared.com', 'User-Agent'=>'Ruby'}).
to_return(:status => 200, :body => data, :headers => {})
gs.trends.v2.browser.from('2016-06-20').to('2016-06-30')
.date_format('yyyy-mm-dd').sort('visits').group(true).form('json').limit(5)
expect(gs.fetch).to eq("a" => [{"test"=>"response"}, {"with"=>"params"}])
end


end