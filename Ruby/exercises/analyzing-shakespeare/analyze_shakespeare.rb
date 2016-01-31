#!/usr/bin/env ruby

require_relative 'lib/counter'

play_filename = ARGV[0]

counter = Counter.new("http://www.ibiblio.org/xml/examples/shakespeare/#{play_filename}.xml")

lines_spoken_by_characters = counter.lines_spoken_by_characters

lines_spoken_by_characters each do |character_lines|
  character = character_lines[:character]

  puts "#{character_lines[:lines]} #{character}"
end
