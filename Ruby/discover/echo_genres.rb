#!/usr/bin/env ruby

require 'json'
require 'net/http'

def all_genres_json(api_key)
    url = "http://developer.echonest.com/api/v4/genre/list?api_key=#{api_key}&format=json"

    resp = Net::HTTP.get_response(URI.parse(url))

    resp.body
end

def all_genres(json)
    # Convert json into a hash
    result = JSON.parse(json)

    if result['response']['status']['code'] == 1
        raise "Error: #{result['response']['status']['message']}"
    end

    result
end

puts all_genres(all_genres_json(ARGV.first)).inspect
