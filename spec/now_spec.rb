describe Gosquared::Now do
  subject(:gs) { described_class.new('demo', 'GSN-2194840-F') }

  Gosquared::Now::DIMENSIONS.each do |dimension|
    before do
      data = '{"a": [{"test": "response"}]}'
      stub_request(:get, "https://api.gosquared.com/now/v3/#{dimension}?api_key=demo&site_token=GSN-2194840-F")
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: data, headers: {})
    end
  end

  Gosquared::Now::DIMENSIONS.each do |dimension|
    it "fetches a request from the GoSquared Now API with #{dimension} dimension" do
      gs.send dimension.to_s
      expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }])
    end
  end

  before do
    data = '{"a": [{"test": "response"}, {"with": "params"}]}'
    stub_request(:get, 'https://api.gosquared.com/now/v3/browsers?api_key=demo&site_token=GSN-2194840-F&limit=5')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: data, headers: {})
  end

  it 'fetches a request from the GoSquared Now API with paramaters' do
    gs.browsers.limit('5')
    expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }, { 'with' => 'params' }])
  end
end
