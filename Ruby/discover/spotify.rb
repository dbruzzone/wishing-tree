require 'sinatra'

get '/' do
  'Hello'
end

get '/login' do
  redirect 'https://accounts.spotify.com/authorize?'
end
