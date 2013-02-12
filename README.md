## GoSquared Ruby API client

This module works with the [GoSquared API][api-docs], making it really easy to integrate GoSquared with your node app. You can also use it to track metrics and events in your application using GoSquared

## Installation
```bash
gem install gosquared
```

## Usage

```ruby
# Create an API client
gosquared_api = GoSquared::API.new(opts)

# Create Event client
gosquared_event = GoSquared::Event.new(opts)

```

##### Options

* api_key: API key from your [account][casa]. Required for API client, not required for event client.
* site_token: Token for the registered site you're working with. Required.
* debugLevel: One of:
	* GoSquared::DEBUG_LEVELS[:ALL]
	* GoSquared::DEBUG_LEVELS[:TRACE]
	* GoSquared::DEBUG_LEVELS[:NOTICE]
	* GoSquared::DEBUG_LEVELS[:WARNING]
	* GoSquared::DEBUG_LEVELS[:FATAL]

### API
```ruby
require 'gosquared'

gosquared_api = GoSquared::API.new({
  :api_key    => 'demo',
  :site_token => 'GSN-181546-E'
})

response = gosquared_api.concurrents(params)
```

All functions listed in the [API documentation][api-docs] are methods you can call on the ```GoSquared::API``` class.


### Tracking

##### Events
Send events to GoSquared:

```ruby
require 'gosquared'

gosquared_event = GoSquared::Event.new({
  :site_token => 'GSN-181546-E'
})

response = gosquared_event.store_event('Test Event', {
	:its => true,
	:'you can' => 'store',
	:any => 'event',
	:properties => 'You Like'
})
```

## Run tests
Install all dependencies using ```bundle``` then:

```bash
rake
```

[api-docs]: https://www.gosquared.com/developer/latest/
[casa]: https://www.gosquared.com/home/developer