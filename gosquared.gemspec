#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = "gosquared"
  spec.version     = "0.1.0"
  spec.authors     = ["Russell Vaughan"]
  spec.email       = ["russell@gosquared.com"]
  spec.homepage    = "https://github.com/rusellvaughan/ruby-library"
  spec.summary     = %q{GoSquared Ruby Client}
  spec.description = %q{For use with the API and for tracking metrics}

  spec.files         = Dir['lib/**/*', 'Gemfile', 'rubygs.gemspec', '.rspec', 'README.md']
  spec.executables   = Dir['bin/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end