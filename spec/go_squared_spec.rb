describe GoSquared do 
	subject(:gs) { described_class.new() }

	DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screen_dimensions sources transactions)
	VERSION = %w(v1 v2 v3)

	DIMENSIONS.each do |dimension|
		it { is_expected.to respond_to(dimension) }  
	end

	VERSION.each do |version|
		it { is_expected.to respond_to(version) }  
	end


	it 'fetches a request from the GoSquared Trends API'do
	data = 'test'
	stub_request(:get, 'https://api.gosquared.com/trends/v2/aggregate?api_key=demo&site_token=GSN-106863-S').
	with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
	to_return(status: 200, body: data, headers: {})
	gs.trends.v2.aggregate
	expect(gs.fetch).to eq('test')
end

it 'fetches a request from the GoSquared Trends API with paramaters'do
data = 'params_test'
stub_request(:get, "https://api.gosquared.com/trends/v2/browser?api_key=demo&site_token=GSN-181546-E&from=2016-06-20&to=2016-06-30&dateFormat=yyyy-mm-dd&sort=visits&group=true&format=json&limit=5").
with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
to_return(status: 200, body: data, headers: {})
gs.trends.v2.browser.from('2016-06-20').to('2016-06-30')
.date_format('yyyy-mm-dd').sort('visits').group(true).form('json').limit(5)
expect(gs.fetch).to eq('params_test')
end


end