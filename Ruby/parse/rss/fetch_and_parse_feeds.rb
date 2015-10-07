#!/usr/bin/env ruby

require 'feedjira'

require 'json'

feed_filename = ARGV.first || 'feeds.txt'

if File.exist?(feed_filename)
    puts "-- Feeds in #{feed_filename}"

    File.open(feed_filename).readlines.each do |url|
        puts "- Feed: #{url}"

        feed = Feedjira::Feed.fetch_and_parse url

        puts "  Title: #{feed.title}"

        feed.entries.each do |entry|
            puts "\t- Entry"

            puts "\t  Title: #{entry.title}"
            puts "\t  URL: #{entry.url}"
            puts "\t  Summery: #{entry.summary}"
        end
    end
else
    puts 'Please specify the name of a file that contains a list of feed URLs to fetch and parse'
end
