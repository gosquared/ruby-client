#Example Usage

```
2.2.2 :001 > require './lib/goSquared.rb'
 
 => true

2.2.2 :002 > gs = GoSquared.new("1F6DLEGZKZ2QUK48","GSN-086224-W")
 
 => #<GoSquared:0x007ff729b74d50 @api_key="1F6DLEGZKZ2QUK48", @site_id="GSN-086224-W">

2.2.2 :003 > gs.now.concurrents

 => #<Now:0x007ff729b6cd80 @site_token="GSN-086224-W", @api_key="1F6DLEGZKZ2QUK48", @client=#<Client:0x007ff729b6cd58>, @dimension="concurrents">

2.2.2 :004 > gs.now.fetch

 => {"visitors"=>0, "returning"=>0, "pages"=>0, "active"=>0, "tagged"=>0}

2.2.2 :005 > gs.trends.browser.from('2016-06-30').to('2016-07-07')

 => #<Trends:0x007ff729b375e0 @site_token="GSN-086224-W", @api_key="1F6DLEGZKZ2QUK48", @client=#<Client:0x007ff729b375b8>, @dimension="browser">

2.2.2 :006 > gs.trends.fetch

 => {"list"=>[{"id"=>"chrome", "browser"=>"chrome", "name"=>"Chrome", "metrics"=>{"visits"=>3}}], "cardinality"=>1, "dimension"=>"browser", "range"=>{"from"=>"2016-06-30T00:00:00+01:00", "to"=>"2016-07-07T23:59:59+01:00"}, "interval"=>"day"}

2.2.2 :007 > gs.account.blocked.address.ip('5.10.148.50')

 => #<Account:0x007ff729b054f0 @site_token="GSN-086224-W", @api_key="1F6DLEGZKZ2QUK48", @client=#<Client:0x007ff729b054c8>, @bots="", @ips="/ips", @visitor="", @dimension_filter="", @dimension="blocked", @data="">

2.2.2 :008 > gs.account.post

Reponse Message: OK
 => #<Net::HTTPOK 200 OK readbody=true>

2.2.2 :010 > gs.tracking.event({event: {name: 'event'}})

 => #<Tracking:0x007ff72a071740 @site_token="GSN-086224-W", @api_key="1F6DLEGZKZ2QUK48", @client=#<Client:0x007ff72a071718>, @dimension="event", @data={:event=>{:name=>"event"}}>

2.2.2 :011 > gs.tracking.post
Reponse Message: OK
 => #<Net::HTTPOK 200 OK readbody=true>

2.2.2 :012 > gs.people.smartgroups

 => #<People:0x007ff729ade490 @site_token="GSN-086224-W", @api_key="1F6DLEGZKZ2QUK48", @person_id="", @person_filter="", @client=#<Client:0x007ff729ade468>, @dimension="smartgroups", @data="">

2.2.2 :013 > gs.people.fetch

 => {"list"=>[{"id"=>"engaged-1-hour", "name"=>"Engaged > 1 Hour", "filters"=>[{"key"=>"property", "path"=>"totals.engaged_time", "operator"=>">", "value"=>3600000}], "prefs"=>{"sortField"=>"totals.engaged_time", "sortDir"=>"desc", "fields"=>["id", "email", "name", "totals.engaged_time", "social", "description", "created_at", "last.seen", "last.location.country.code", "totals.visits"]}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/engaged-1-hour", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/engaged-1-hour/people", "method"=>"GET"}]}, {"id"=>"last-seen-1-day", "name"=>"Last Seen < 1 Day", "filters"=>[{"key"=>"property", "path"=>"last.seen", "operator"=>"><", "direction"=>"past", "number"=>1, "period"=>"days"}], "prefs"=>{"sortField"=>"last.seen", "sortDir"=>"desc", "fields"=>["id", "email", "name", "last.seen", "totals.engaged_time", "social", "description", "created_at", "last.location.country.code", "totals.visits"]}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/last-seen-1-day", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/last-seen-1-day/people", "method"=>"GET"}]}, {"id"=>"last-seen-35-days", "name"=>"Last Seen > 35 Days", "filters"=>[{"key"=>"property", "path"=>"last.seen", "operator"=>"<", "number"=>35, "period"=>"days"}], "prefs"=>{"sortField"=>"last.seen", "sortDir"=>"desc", "fields"=>["id", "email", "name", "last.seen", "totals.engaged_time", "social", "description", "created_at", "last.location.country.code", "totals.visits"]}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/last-seen-35-days", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/last-seen-35-days/people", "method"=>"GET"}]}, {"id"=>"most-active", "name"=>"Most Active", "filters"=>[{"key"=>"property", "path"=>"totals.visits", "operator"=>">", "value"=>1}], "prefs"=>{"sortField"=>"totals.visits", "sortDir"=>"desc", "fields"=>["id", "email", "name", "totals.visits", "social", "description", "created_at", "last.seen", "last.location.country.code"], "columnWidths"=>{}}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/most-active", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/most-active/people", "method"=>"GET"}]}, {"id"=>"new-trial-users", "name"=>"New Trial Users", "filters"=>[{"key"=>"property", "path"=>"last.seen", "operator"=>"><", "direction"=>"past", "number"=>1, "period"=>"days"}], "prefs"=>{"sortField"=>"last.seen", "sortDir"=>"desc", "fields"=>["id", "email", "name", "social", "description", "created_at", "last.seen", "last.location.country.code", "totals.visits"], "columnWidths"=>{"id"=>100}}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/new-trial-users", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/new-trial-users/people", "method"=>"GET"}]}, {"id"=>"recently-created-1", "name"=>"Recently Created", "filters"=>[], "prefs"=>{"sortField"=>"last.seen", "sortDir"=>"desc", "fields"=>["id", "email", "name", "social", "description", "created_at", "last.seen", "last.location.country.code", "totals.visits"], "columnWidths"=>{"id"=>100, "social"=>295}}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/recently-created-1", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/recently-created-1/people", "method"=>"GET"}]}, {"id"=>"referring-url", "name"=>"Referring URL", "filters"=>[{"key"=>"property", "path"=>"first.referrer.href", "operator"=>"defined"}], "prefs"=>{"sortField"=>"last.seen", "sortDir"=>"desc", "fields"=>["id", "email", "name", "social", "description", "created_at", "last.seen", "last.location.country.code", "totals.visits", "first.referrer.href"], "columnWidths"=>{"id"=>100}}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/referring-url", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/referring-url/people", "method"=>"GET"}]}, {"id"=>"social-media-influencers", "name"=>"Social Media Influencers", "filters"=>[{"key"=>"property", "path"=>"social.klout.score", "operator"=>">", "value"=>40}], "prefs"=>{"sortField"=>"social.klout.score", "sortDir"=>"desc", "fields"=>["id", "email", "name", "social.klout.score", "social", "description", "created_at", "last.seen", "last.location.country.code", "totals.visits"]}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/social-media-influencers", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/social-media-influencers/people", "method"=>"GET"}]}, {"id"=>"test-group", "name"=>"Test Group", "filters"=>[{"key"=>"property", "path"=>"first.referrer.href", "operator"=>"defined"}, {"key"=>"triggered-event", "name"=>"Entered Smart Group", "field"=>"last", "operator"=>">", "number"=>30, "period"=>"days"}], "prefs"=>{"sortField"=>"email", "sortDir"=>"asc", "fields"=>["id", "email", "name", "social", "description", "created_at", "last.seen", "last.location.country.code", "totals.visits"], "columnWidths"=>{"id"=>100}}, "_links"=>[{"rel"=>"self", "href"=>"https://api.gosquared.com/people/v1/smartgroups/test-group", "method"=>"GET"}, {"rel"=>"members", "href"=>"https://api.gosquared.com/people/v1/smartgroups/test-group/people", "method"=>"GET"}]}], "cardinality"=>9}
2.2.2 :014 >

```

#Run Tests

```
Rspec
```
