describe Gosquared::Tracking do
	subject(:gs) { described_class.new("demo", "GSN-2194840-F") }

	VERSION = "3.0.6"

	Gosquared::Tracking::DIMENSIONS.each do |dimension|
		before do
			stub_request(:post, "https://api.gosquared.com/tracking/v1/#{dimension}?api_key=demo&site_token=GSN-2194840-F").
			with(:body => "[{\"person_id\":\"email:test@example.com\",\"properties\":{\"email\":\"test@example.com\"}}]",
				:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'ruby-client/'+VERSION }).
			to_return(:status => 200, :body => "", :headers => {response: "success"})
		end
	end

	Gosquared::Tracking::DIMENSIONS.each do |dimension|
		it "posts a request to the GoSquared Track API with #{dimension} dimension" do
			gs.send "#{dimension}", ({person_id: "email:test@example.com",
				properties:{email: "test@example.com"}})
			expect(gs.post.code).to eq('200')
		end
	end

	describe "#event" do
		before do
			stub_request(:post, "https://api.gosquared.com/tracking/v1/event?api_key=demo&site_token=GSN-2194840-F").
			with(:body => "[{\"event\":{\"name\":\"event\"}}]",
				:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'ruby-client/'+VERSION}).
			to_return(:status => 200, :body => "", :headers => {})
			@data = {person_id: nil,  event: { name: 'event' } }
		end

		it 'Tracks an anonymous event when a person_id is nil' do
			gs.event(@data)
			expect(gs.post.code).to eq('200')
		end

		before do
			stub_request(:post, "https://api.gosquared.com/tracking/v1/event?api_key=demo&site_token=GSN-2194840-F").
			with(:body => "[{\"person_id\":\"12345\",\"event\":{\"name\":\"event\"}}]",
				:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'ruby-client/'+VERSION}).
			to_return(:status => 200, :body => "", :headers => {})
			@data = {person_id: '12345',  event: { name: 'event' } }
		end

		it 'Tracks an anonymous event when a person_id is not nil' do
			gs.event(@data)
			expect(gs.post.code).to eq('200')
		end

	end

end
