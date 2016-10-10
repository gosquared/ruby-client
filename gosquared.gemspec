#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = "gosquared"
  spec.version     = "3.0.0"

  spec.authors     = ["Russell Vaughan"]
  spec.email       = ["russell@gosquared.com"]
  spec.homepage    = "https://github.com/gosquared/ruby-client"
  spec.summary     = %q{GoSquared Ruby Library}
  spec.description = %q{A Ruby library for posting data from your application to the GoSquared Tracking API and fetching metrics from the GoSquared Reporting API.}

  spec.files         = Dir['lib/**/*', 'Gemfile', 'rubygs.gemspec', '.rspec', 'README.md', 'LICENSE']
  spec.executables   = Dir['bin/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']
  spec.licenses       = ['MIT']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
