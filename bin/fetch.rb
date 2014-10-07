#!/usr/bin/env ruby

require 'redis'
require 'date'
require 'json'

redis = Redis.new(url: ENV['REDISTOGO_URL'] || 'redis://localhost:6379')
date = ARGV.first || Date.today.iso8601

body = %x(phantomjs phantomjs/fetch.js #{date}).chomp

entry = {
  date: date,
  body: body
}

STDERR.puts entry.inspect

redis.set("holidays:#{date}", JSON.dump(entry))
