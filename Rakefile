#!/usr/bin/env rake

require 'bundler/setup'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/*.rb'
end

task :default => [:test]