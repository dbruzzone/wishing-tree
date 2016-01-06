require 'sinatra'

require 'dotenv'

Dotenv.load

require_relative 'lib/string_utils'
require_relative 'lib/url_utils'

client_id = ENV[ 'SPOTIFY_CLIENT_ID' ]
client_secret = ENV[ 'SPOTIFY_CLIENT_SECRET' ]

state_key = ENV[ 'STATE_KEY' ]
scope = ENV[ 'SCOPE' ]
redirect_uri = ENV[ 'REDIRECT_URL' ]

get '/' do
  'Hello'
end

get '/login' do
  state = StringUtils.generate_random_string(16)

  response.set_cookie state_key, state

  query_parameters = {
    response_type: 'code',
    client_id: client_id,
    scope: scope,
    redirect_uri: redirect_uri,
    state: state
  }

  # Request authorization
  redirect "#{ENV[ 'SPOTIFY_AUTHORIZATION_URL' ]}#{URLUtils::query_string(query_parameters)}"
end

get '/auth/spotify/callback' do
  code = params['code'] || nil
  state = params['state'] || nil

  stored_state = request.cookies[ state_key ] || nil

  if state.nil? or state != stored_state
    redirect '/#error=state_mismatch'
  else
    # TODO
  end

  'Succeeded'
end
