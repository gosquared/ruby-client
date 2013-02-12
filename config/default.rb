module GoSquared
  API_ENDPOINT = "https://api.gosquared.com"
  EVENT_ENDPOINT = "https://data.gosquared.com/event"
  API_FUNCTIONS = [
    "aggregateStats",
    "campaigns",
    "concurrents",
    "engagement",
    "functions",
    "geo",
    "ignoredVisitors",
    "organics",
    "overview",
    "pages",
    "referrers",
    "reportPreferences",
    "sites",
    "time",
    "timeSeries",
    "visitors"
  ]
  DEBUG_LEVELS = {
    :TRACE => 1,
    :NOTICE => 1<<1,
    :WARNING => 1<<2,
    :FATAL => 1<<3
  }
  DEBUG_LEVELS[:ALL] = (2**DEBUG_LEVELS.length) - 1
  DEBUG_DEFAULT_LEVEL = DEBUG_LEVELS[:ALL] ^ (DEBUG_LEVELS[:NOTICE] | DEBUG_LEVELS[:TRACE])
  DEBUG_CODES = {
    1 => "A site token must be given.",
    2 => "An API key must be given.",
    3 => "API version has not been specified. Using the default."
  }
end