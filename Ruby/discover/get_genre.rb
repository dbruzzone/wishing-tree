#!/usr/bin/env ruby

require 'json'
require 'open-uri'

require 'nokogiri'

data = JSON.parse($stdin.gets)

data.each do |child|
  puts "Genre: #{child}"
end
