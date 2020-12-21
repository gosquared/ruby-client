#!/usr/bin/env gem build

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = 'gosquared'
  spec.version     = '3.1.0'

  spec.authors     = ['Russell Vaughan']
  spec.email       = ['russell@gosquared.com']
  spec.homepage    = 'https://github.com/gosquared/ruby-client'
  spec.summary     = 'GoSquared Ruby Library'
  spec.description = 'GoSquared is the all-in-one growth software for SaaS businesses.
  This gem is for posting data from your application to the GoSquared Tracking API and fetching metrics from the GoSquared Reporting API.'
  spec.files         = Dir['lib/**/*', 'Gemfile', 'rubygs.gemspec', '.rspec', 'README.md', 'LICENSE']
  spec.executables   = Dir['bin/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']
  spec.licenses = ['MIT']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
