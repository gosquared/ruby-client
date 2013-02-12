#!/usr/bin/env rake

require 'bundler/setup'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/*.rb'
end

Rake::TestTask.new("test:event") do |t|
  t.pattern = 'test/event.rb'
end

task :default => [:test]