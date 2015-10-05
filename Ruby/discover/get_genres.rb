#!/usr/bin/env ruby

require 'json'
require 'open-uri'

require 'nokogiri'

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

def walk_tree(container, child_list, level = 0)
    new_level = level + 1

    children = container.xpath('./ul/li')

    if children
        children.each do |child|
            child_link = child.css('a')

            child_title = child_link.attribute('title')
            child_url = child_link.attribute('href')

            new_child = Genre.new(child_title, child_url)

            child_list << new_child

            puts "#{"\t" * level}- #{child_title}"

            walk_tree(child, new_child.children, new_level)
        end
    end
end

doc = Nokogiri::HTML(open(ARGV.first))
genre_containers = doc.css('.div-col.columns.column-count.column-count-4')

root_genres = []

genre_containers.each do |genre_container|
    walk_tree(genre_containers, root_genres)
end

puts root_genres.to_json
