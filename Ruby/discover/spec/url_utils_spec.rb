require 'url_utils'

describe URLUtils do
  describe ".query_string" do
    context "given a hash that contains the desired query parameters" do
      it "returns the desired query string" do
        query_parameters = {
          response_type: 'code',
          client_id: 'xxxxxxxxxx0e4ff192d261xxxxxxxxxx',
          scope: 'user-read-private user-read-email',
          redirect_uri: 'http://localhost:4567/callback',
          state: 'xxxxxxxxxxaabbcc'
        }

        expect(URLUtils::query_string(query_parameters)).to eql('&response_type=code&client_id=xxxxxxxxxx0e4ff192d261xxxxxxxxxx&scope=user-read-private+user-read-email&redirect_uri=http%3A%2F%2Flocalhost%3A4567%2Fcallback&state=xxxxxxxxxxaabbcc')
      end
    end
  end
end

