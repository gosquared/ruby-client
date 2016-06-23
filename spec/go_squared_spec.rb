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


	before(:each) do
		data = 'test'
		stub_request(:get, 'https://api.gosquared.com/trends/v2/aggregate?api_key=demo&site_token=GSN-106863-S').
		with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
		to_return(status: 200, body: data, headers: {})
	end

	it 'fetches a request from the GoSquared Trends API'do
	gs.trends.v2.aggregate
	expect(gs.fetch).to eq('test')
	end

	it 'fetches a request from the GoSquared Trends API with paramaters'do
	gs.trends.v2.aggregate.from('2016-06-20').to('2016-06-30')
	.dateFormat('yyyy-mm-dd').sort('field').group(true)
	expect(gs.fetch).to eq('params_test')
	end

	# curl "https://api.gosquared.com/trends/v2/browser?api_key=demo&site_token=GSN-106863-S&from='2016-06-20'&to='2016-06-30'&format=json&limit=5&group=true" 

end