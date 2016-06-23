describe GoSquared do 
	subject(:gs) { described_class.new() }

	DIMENSIONS = %w(aggregate browser category country event language organisation os page path1 product screen_dimensions sources transactions)

 	DIMENSIONS.each do |dimension|
 	it { is_expected.to respond_to(dimension) }  
 	end

	

	before(:each) do
		data = 'test'
		stub_request(:get, 'https://api.gosquared.com/trends/v2/aggregate').
		with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
		to_return(status: 200, body: data, headers: {})
	end

	it 'fetches a request from the GoSquared Trends API'do
	gs.trends.v2.aggregate
	expect(gs.fetch).to eq('test')
end

end