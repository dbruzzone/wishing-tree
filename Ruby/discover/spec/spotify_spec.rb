require File.expand_path '../spec_helper.rb', __FILE__

describe "My Spotify application" do
  it "should allow users to access the home page" do
    get '/'

    expect(last_response).to be_ok

    expect(last_response.body).to match /Hello/
  end

  it 'should redirect users when they log in' do
    get '/login'

    expect(last_response).to be_redirect

    follow_redirect!

    expect(last_request.url).to match /https:\/\/accounts\.spotify\.com\/authorize\?response_type=code&client_id=.{32}&scope=user-read-private\+user-read-email&redirect_uri=http%3A%2F%2Flocalhost%3A4567%2Fauth%2Fspotify%2Fcallback&state=[a-zA-Z0-9]{16}/
  end

  it "should set the 'spotify_auth_state' cookie redirect when users log in" do
    get '/login'

    expect(rack_mock_session.cookie_jar['spotify_auth_state']).to match /[a-zA-Z0-9]{16}/
  end
end
