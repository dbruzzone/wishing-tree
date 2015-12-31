require 'cgi'

class URLUtils
  def self.query_string(params)
    query_string = params.inject('') do | result, (key, value) |
      result << "&#{key}=#{CGI::escape(value)}"
    end
  end
end
