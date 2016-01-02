require 'sinatra'

require_relative 'lib/string_utils'
require_relative 'lib/url_utils'

# There are other/better ways to configure the server's settings (such as dotenv -
# https://github.com/bkeepers/dotenv) but for now, since I'm  starting by porting the Spotify Web
# API example at https://github.com/spotify/web-api-auth-examples/tree/master/authorization_code,
# I'm keeping things simple
client_id = ENV['DISCOVER_SPOTIFY_CLIENT_ID']
redirect_uri = 'http://localhost:4567/auth/spotify/callback'

state_key = 'spotify_auth_state'

get '/' do
  'Hello'
end

get '/login' do
  state = StringUtils.generate_random_string(16)

  response.set_cookie state_key, state

  scope = 'user-read-private user-read-email'

  query_parameters = {
    response_type: 'code',
    client_id: client_id,
    scope: scope,
    redirect_uri: redirect_uri,
    state: state
  }

  # Request authorization
  redirect "https://accounts.spotify.com/authorize?#{URLUtils::query_string(query_parameters)}"
end
