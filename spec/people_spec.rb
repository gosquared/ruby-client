describe Gosquared::People do
  subject(:gs) { described_class.new('demo', 'GSN-106863-S') }

  Gosquared::People::DIMENSIONS.each do |dimension|
    before do
      data = '{"a": [{"test": "response"}]}'
      stub_request(:get, "https://api.gosquared.com/people/v1/#{dimension}?api_key=demo&site_token=GSN-106863-S")
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: data, headers: {})
    end
  end

  Gosquared::People::DIMENSIONS.each do |dimension|
    it "fetches a request from the GoSquared People API with #{dimension} dimension" do
      next if dimension == 'people'

      gs.send dimension.to_s
      expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }])
    end
  end

  before do
    data = '{"a": [{"test": "response"}, {"with": "params"}]}'
    stub_request(:get, 'https://api.gosquared.com/people/v1/people/example.email@example.com/devices?api_key=demo&site_token=GSN-106863-S')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: data, headers: {})
  end

  it 'fetches a request from the GoSquared People API with a person_id and paramaters' do
    gs.people.person_id('example.email@example.com', 'devices')
    expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }, { 'with' => 'params' }])
  end

  Gosquared::People::DIMENSIONS.each do |dimension|
    before do
      data = '{"a": [{"test": "response"}, {"with": "params"}]}'
      stub_request(:get, "https://api.gosquared.com/people/v1/#{dimension}?api_key=demo&site_token=GSN-106863-S&limit=5")
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: data, headers: {})
    end
  end

  Gosquared::People::DIMENSIONS.each do |dimension|
    it 'fetches a request from the GoSquared People API with dimension and paramaters' do
      gs.send(dimension.to_s).limit(5)
      expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }, { 'with' => 'params' }])
    end
  end

  before do
    data = '{"a": [{"test": "response"}, {"with": "filters"}]}'
    stub_request(:get, 'https://api.gosquared.com/people/v1/people?api_key=demo&filters=%5B%7B%22key%22:%22property%22,%22path%22:%22last.location.city%22,%22operator%22:%22contains%22,%22value%22:%22london%22%7D,%7B%22key%22:%22and%22,%22filters%22:%5B%7B%22key%22:%22property%22,%22path%22:%22totals.visits%22,%22operator%22:%22%3E%22,%22value%22:%221000%22%7D%5D%7D%5D&site_token=GSN-106863-S')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: data, headers: {})
  end

  it 'fetches a request from the GoSquared People API with filtering on properties' do
    array = [
      {
        key: 'property',
        path: 'last.location.city',
        operator: 'contains',
        value: 'london'
      },
      {
        key: 'and',
        filters: [
          {
            "key": 'property',
            "path": 'totals.visits',
            "operator": '>',
            "value": '1000'
          }
        ]
      }
    ]
    gs.people.people.filters(array)
    expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }, { 'with' => 'filters' }])
  end

  it 'fetches the people in a smartgroup from the GoSquared People API' do
    data = '{"a": [{"test": "response"}]}'
    stub_request(:get, 'https://api.gosquared.com/people/v1/smartgroups/wat/people?api_key=demo&site_token=GSN-106863-S')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: data, headers: {})
    gs.people.smartgroups('wat', 'people')
    expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }])
  end

  it 'fetches the people in a smartgroup from the GoSquared People API' do
    data = '{"a": [{"test": "response"}]}'
    stub_request(:get, 'https://api.gosquared.com/people/v1/smartgroups/wat/count/latest?api_key=demo&site_token=GSN-106863-S')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: data, headers: {})
    gs.people.smartgroups('wat', 'count')
    expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }])
  end

  it 'fetches smartgroups from the GoSquared People API' do
    data = '{"a": [{"test": "response"}]}'
    stub_request(:get, 'https://api.gosquared.com/people/v1/smartgroups?api_key=demo&site_token=GSN-106863-S')
      .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host' => 'api.gosquared.com', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: data, headers: {})
    gs.people.smartgroups
    expect(gs.fetch).to eq('a' => [{ 'test' => 'response' }])
  end

  it 'deletes a person from a project' do
    stub_request(:delete, "https://api.gosquared.com/people/v1/people/1?api_key=demo&site_token=GSN-106863-S").
      with(:body => "[{}]",
         :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "", :headers => {})
    gs.people.people.person_id('1')
    response = gs.people.delete
    expect(response.code).to eq("200")
  end

end
