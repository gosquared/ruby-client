## GoSquared Ruby Gem

[![Build Status](https://travis-ci.org/gosquared/ruby-client.svg?branch=master)](https://travis-ci.org/gosquared/ruby-gem)

**This is an early beta, please open an issue if you find anything not working, or to leave feedback for improvement. You can also get in touch directly: russell@gosquared.com**

This gems works with the [GoSquared API](https://www.gosquared.com/docs/api/), making it simple to integrate GoSquared with your Rails app. You can use it for both fetching metrics from your GoSquared account and also posting new events and contacts.

All functions listed in the API documentation are methods you can call on the GoSquared class.

You can generate an API key from your [GoSquared Account Settings](https://www.gosquared.com/settings/api).


#Installation

```ruby
gem install gosquared
```

Then require GoSquared in your application

```ruby
require 'gosquared'
```

#Tracking API
This is for sending data to GoSquared. It allows you to track:
* Events
* Transactions
* People profiles

##Track Events
```ruby

gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

gs.tracking.event({ event: { name: 'event' } })

#builds the url to the 'GoSquared Tracking' endpoint with the "events" dimension and an event to add to the events list

gs.tracking.post

#posts the data to the 'GoSquared Tracking' endpoint

Response Message: OK
=> #<Net::HTTPOK 200 OK readbody=true>

```

##Track Transactions

```ruby
gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

gs.tracking.transaction({
  transaction: { id: "1", revenue: 50, quantity: 1,
  previous_transaction_timestamp: Time.new }
  })

gs.tracking.post

Response Message: OK
=> #<Net::HTTPOK 200 OK readbody=true>
```

##Create or Update People profiles

This method is useful for importing existing user profiles into GoSquared people and updating profiles you have already added.

It's highly recommended that you also implement the front end [javascript 'identify' method](https://www.gosquared.com/docs/api/javascript-tracking-code/identify-users) on your site. This enables us to track a the user's session activity and browser information against their People profile.

We also recommend using an email address for the `person_id`. To do this, the email address needs to be prefixed with `email:` like in the example below. 

```ruby
gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

gs.tracking.identify({
  person_id: "email:user@test.com", # Required

  # Reserved property names
  properties: {
    name: "Test User",
    username: "testuser",
    phone: "+44123456789",
    created_at:"2016-06-07T15:44:20Z", # ISO 8601 formatted String
    company_name:"GoSquared",
    company_industry:"Customer Analytics",
    company_size: 15000,

    # Custom properties
    custom: {
      # custom_property_name: "custom property value"  # You can track as many custom properties as you like
    }
  }
})

gs.tracking.post

Response Message: OK
=> #<Net::HTTPOK 200 OK readbody=true>
```


#Reporting API
This is for pulling data from your GoSquared account. It is split into 3 sections;
* Now - realtime data
* Trends – historical data (includes ecommerce)
* People - user data
* Account - administration

##Now
The Now API provides real-time concurrent information about your sites and apps, such as the number of concurrent visitors online, the most popular pages right now, the most influential traffic sources, and much more.

_Now Example:_

```ruby
gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

#instantiates new GoSquared object

gs.now.concurrents

#builds the url to the 'GoSquared Now' endpoint with the "Concurrents dimension"

gs.now.fetch

#fetches the data from the 'GoSquared Now' endpoint

=> {"visitors"=>3, "returning"=>1, "pages"=>0, "active"=>0, "tagged"=>0}
```

##Trends
The Trends API provides historical analytics information for any given period in a project's history. The data for the current period updates in real-time, so the figures are always fresh and up-to-date.

_Trends Example:_

```ruby
gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

gs.trends.browser.from('2016-06-30').to('2016-07-07')

#builds the url to the 'GoSquared Trends' endpoint with the "Trends dimension" and date filters

gs.trends.fetch

#fetches the filtered data from the 'GoSquared Trends' endpoint

=> {"list"=>[{"id"=>"chrome", "browser"=>"chrome", "name"=>"Chrome", "metrics"=>{"visits"=>3}}], "cardinality"=>1, "dimension"=>"browser", "range"=>{"from"=>"2016-06-30T00:00:00+01:00", "to"=>"2016-07-07T23:59:59+01:00"}, "interval"=>"day"}

```

##People


```ruby

gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

gs.people.smartgroups

#builds the url to the 'GoSquared People' endpoint with the "people" dimension.

gs.people.fetch

#fetches all smartgroups associated with the account.

```

##Account
The Account API allows you to perform administrative actions against GoSquared accounts. This includes actions like changing settings, configuration, and listing resources under the account.

_Account Example:_

```ruby

gs = Gosquared::RubyLibrary.new("your_API_key","your_project_token")

gs.account.blocked.ips.ip('5.10.148.50')

#builds the url to the 'GoSquared Account' endpoint with the "Blocked dimension" and ip address to add to the blocked list

gs.account.post

#posts the data to the 'GoSquared Account' endpoint

Response Message: OK
=> #<Net::HTTPOK 200 OK readbody=true>

gs.account.sites.token("your_site_token")

#builds the url to the 'GoSquared Account' endpoint with the "Sites" dimension and token you want to retrieve the site by.

gs.account.sites.fetch

```


### Optional install of Analytics and Chat 

While it is not required to make use of our library to interact with our Tracking and Reporting API's, you can also quickly install GoSquared's tracking code on your app. GoSquared uses a javascript code snippet to track pageviews and optionally load the GoSquared Live Chat widget.

If you don't currently have a GoSquared tracking code on your site, you can quickly add the the code to all of your Rails’ views by running this:

```ruby
rails generate gosquared:config 'your_project_token'
```

This will insert a `<script>` tag automatically before the closing `</body>` tag on each view rendered.

After generating your config file, if there are any controllers you would prefer not to have the tracking code automatically inserted in, you'll just need to add the following to that specific controller:

```ruby
skip_after_action :add_gosquared_script
```

#Tests

```ruby
rspec
```
