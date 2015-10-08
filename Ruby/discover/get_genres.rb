#!/usr/bin/env ruby

require 'optparse'

require 'json'
require 'open-uri'

require 'nokogiri'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: get_genres.rb [options] URL'

  opts.on('-v', '--[no-]verbose', 'Print the list of genres that the program finds') do |v|
    options[:verbose] = v
  end
end.parse!

class Genre
    attr_accessor :title, :url, :children

    def initialize(title, url)
        @title = title
        @url = url

        @children = []
    end

    def to_json(*a)
        {
            title: @title,
            url: @url,
            children: @children.each { |child| child.to_json }
        }.to_json(*a)
    end
end

def walk_tree(container, child_list, verbose = false, level = 0)
    new_level = level + 1

    children = container.xpath('./ul/li')

    if children
        children.each do |child|
            child_link = child.css('a')

            child_title = child_link.attribute('title')
            child_url = child_link.attribute('href')

            new_child = Genre.new(child_title, child_url)

            child_list << new_child

            # TODO: For some reason, 'if options[:verbose]' doesn't work; figure out why
            #if options[:verbose]
            if verbose 
                puts "#{"\t" * level}- #{child_title}"
            end

            walk_tree(child, new_child.children, verbose, new_level)
        end
    end
end

doc = Nokogiri::HTML(open(ARGV.first))
genre_containers = doc.css('.div-col.columns.column-count.column-count-4')

root_genres = []

genre_containers.each do |genre_container|
    walk_tree(genre_containers, root_genres, options[:verbose])
end

# TODO: Figure out if it's possible to prevent the program's output from appearing
# in the terminal when it's piped to another program
$stdout.puts root_genres.to_json
