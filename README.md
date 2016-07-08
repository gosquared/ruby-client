## GoSquared Ruby Gem

This gems works with the GoSquared API, making it simple to integrate GoSquared with your Rails app. You can use it for both fetching metrics from your GoSquared account and also posting new events and contacts. 

All functions listed in the API documentation are methods you can call on the GoSquared class.

##Example Usage

```
gem install gosquared 
```

#Example 'Now' Endpoint Usage

```
gs = GoSquared.new("demo","GSN-2194840-F")

#instantiates new GoSquared object

gs.now.concurrents

#builds the url to the 'GoSquared Now' endpoint with the "Concurrents dimension"

gs.now.fetch

#fetches the data from the 'GoSquared Now' endpoint

=> {"visitors"=>3, "returning"=>1, "pages"=>0, "active"=>0, "tagged"=>0}
```

#Example 'Trends' Endpoint Usage

```
gs = GoSquared.new("demo","GSN-2194840-F")

gs.trends.browser.from('2016-06-30').to('2016-07-07')

#builds the url to the 'GoSquared Trends' endpoint with the "Trends dimension" and date filters

gs.trends.fetch

#fetches the filtered data from the 'GoSquared Trends' endpoint

=> {"list"=>[{"id"=>"chrome", "browser"=>"chrome", "name"=>"Chrome", "metrics"=>{"visits"=>3}}], "cardinality"=>1, "dimension"=>"browser", "range"=>{"from"=>"2016-06-30T00:00:00+01:00", "to"=>"2016-07-07T23:59:59+01:00"}, "interval"=>"day"}

```

#Example 'Account' Endpoint Usage

```

gs = GoSquared.new("demo","GSN-2194840-F")

gs.account.blocked.ips.ip('5.10.148.50')

#builds the url to the 'GoSquared Account' endpoint with the "Blocked dimension" and ip address to add to the blocked list

gs.account.post

#posts the data to the 'GoSquared Account' endpoint

Reponse Message: OK
=> #<Net::HTTPOK 200 OK readbody=true>

```

#Example 'Tracking' Endpoint Usage

```

gs = GoSquared.new("demo","GSN-2194840-F")

gs.tracking.event({event: {name: 'event'}})

#builds the url to the 'GoSquared Tracking' endpoint with the "events" dimension and an event to add to the events list

Reponse Message: OK
=> #<Net::HTTPOK 200 OK readbody=true>

```

#Example 'People' Endpoint Usage

```

gs = GoSquared.new("demo","GSN-2194840-F")

gs.people.smartgroups

#builds the url to the 'GoSquared People' endpoint with the "people" dimension.

gs.people.fetch

#fetches all smartgroups associated with the account.

```

## Tests

#Run Tests

```
rspec
```
