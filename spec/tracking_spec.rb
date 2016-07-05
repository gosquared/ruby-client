describe GoSquared::Tracking do 
	subject(:gs) { described_class.new() }

	GoSquared::Tracking::DIMENSIONS.each do |dimension|
		it { is_expected.to respond_to(dimension) }  
	end

	before do 
		GoSquared::Tracking::DIMENSIONS.each do |dimension|	
			stub_request(:post, "https://api.gosquared.com/tracking/v1/#{dimension}?api_key=1F6DLEGZKZ2QUK48&site_token=GSN-086224-W").
			with(:body => "[ {\"person_id\":\"email:test@example.com\",\"properties\":{\"email\":\"test@example.com\"}} ]",
				:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).	
			to_return(:status => 200, :body => "", :headers => {response: "success"})
		end
	end

	GoSquared::Tracking::DIMENSIONS.each do |dimension|	
		it "posts a request to the GoSquared Track API with #{dimension} dimension" do
			gs.v1.send "#{dimension}", ({person_id: "email:test@example.com", 
				properties:{email: "test@example.com"}})
			expect(gs.post.code).to eq('200')
		end
	end

end