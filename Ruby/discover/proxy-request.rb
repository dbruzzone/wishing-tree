require 'uri'

require 'net/http'

uri = URI.parse('http://www.google.com/')

proxy_address = 'localhost'
proxy_port = 8080

http = Net::HTTP.new(uri.host, uri.port, proxy_address, proxy_port)

response = http.request(Net::HTTP::Get.new(uri.request_uri))

puts "Response body:\n#{response.body}"
