require File.expand_path '../spec_helper.rb', __FILE__

describe "My Spotify application" do
  it "should allow users to access the home page" do
    get '/'

    expect(last_response).to be_ok

    expect(last_response.body).to match /Hello/
  end

  it "should redirect users when they log in" do
    get '/login'

    expect(last_response).to be_redirect

    follow_redirect!

    expect(last_request.url).to eq 'https://accounts.spotify.com/authorize'
  end
end
