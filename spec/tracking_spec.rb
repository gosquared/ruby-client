describe Tracking do 
	subject(:gs) { described_class.new("demo", "GSN-2194840-F") }

	Tracking::DIMENSIONS.each do |dimension|	
	before do 
			stub_request(:post, "https://api.gosquared.com/tracking/v1/#{dimension}?api_key=demo&site_token=GSN-2194840-F").
			with(:body => "[ {\"person_id\":\"email:test@example.com\",\"properties\":{\"email\":\"test@example.com\"}} ]",
				:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).	
			to_return(:status => 200, :body => "", :headers => {response: "success"})
		end
	end

	Tracking::DIMENSIONS.each do |dimension|	
		it "posts a request to the GoSquared Track API with #{dimension} dimension" do
			gs.send "#{dimension}", ({person_id: "email:test@example.com", 
				properties:{email: "test@example.com"}})
			expect(gs.post.code).to eq('200')
		end
	end

end