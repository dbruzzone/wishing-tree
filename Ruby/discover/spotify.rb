require 'sinatra'

require 'omniauth-spotify'

configure do
  enable :sessions

  use OmniAuth::Builder do
    # ENV['SPOTIFY_SCOPE'] can be set to something like 'playlist-read-private user-read-private user-read-email'.
    # See https://developer.spotify.com/web-api/using-scopes/ for more information
    #provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'], scope: ENV['SPOTIFY_SCOPE']
    provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'], scope: 'playlist-read-private user-read-private user-read-email'
  end
end

helpers do
  # Checks whether the current user is authenticated
  def current_user
    !session[:uid].nil?
  end
end

before do
  # Don't redirect to Spotify if the path starts with '/auth/'
  pass if request.path_info =~ /^\/auth\//

  # If the path matches '/auth/spotify', redirect the request to Spotify
  redirect to('/auth/spotify') unless current_user
end

get '/auth/spotify/callback' do
  session[:uid] = env['omniauth.auth']['uid']

  redirect to('/')
end

get '/auth/failure' do
  puts 'Failure'
end

get '/' do
  'Hello omniauth-spotify'
end
