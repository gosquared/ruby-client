#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = "gosquared"
  spec.version     = "0.0.2"
  spec.authors     = ["Geoff Wagstaff"]
  spec.email       = ["geoff@gosquared.com"]
  spec.homepage    = "https://github.com/gosquared/ruby-client"
  spec.summary     = %q{Official GoSquared Ruby Client}
  spec.description = %q{For use with the API and for tracking metrics}

  # Packaged like a gem so that we can easily share it between projects
  # spec.rubyforge_project = "infrastructure"

  spec.files         = Dir['lib/**/*', 'examples/**/*', 'benchmarks/**/*', 'Gemfile', 'gosquared.gemspec', 'Rakefile', 'README.md', 'LICENSE']
  spec.executables   = Dir['bin/*']
  spec.test_files    = Dir['test/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '~> 3.2.0'
  spec.add_development_dependency 'rake', '~> 0.9.2'

  spec.add_runtime_dependency 'faraday', '~> 0.8.5'
  spec.add_runtime_dependency 'json', '~> 1.7.6'
end
