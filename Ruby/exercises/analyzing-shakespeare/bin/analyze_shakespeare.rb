#!/usr/bin/env ruby

require_relative '../lib/counter'

play_name = ARGV[0]

counter = Counter.new

url = "http://www.ibiblio.org/xml/examples/shakespeare/#{play_name}.xml"
document = counter.get_document(url)

# TODO
#characters = counter.find_characters(document)

#characters.each do |character|
  # Downcase everything in character then capitalize the first letter of each word
# puts "- #{character.downcase.split(" ").map(&:capitalize).join(" ")}"
#end

lines_spoken_by_characters = counter.count_lines_spoken_by_characters(document)

lines_spoken_by_characters.each do |character_name, lines|
  puts "#{lines}\t#{character_name}"
end
