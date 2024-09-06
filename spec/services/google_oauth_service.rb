require 'rails_helper'
require 'cgi'

RSpec.describe GoogleOauthService do
  describe '#google_oauth2_url' do
    let(:google_oauth_service) { GoogleOauthService.new }

    before do
      allow(ENV).to receive(:[]).with('GOOGLE_CLIENT_ID').and_return('test-client-id')
    end

    it 'generates the correct OAuth2 URL' do
      expected_client_id = 'test-client-id'
      expected_redirect_uri = CGI.escape('http://localhost:5000/api/v1/auth/google_oauth2/callback')
      expected_scope = CGI.escape('email profile https://www.googleapis.com/auth/calendar.events')

      expected_url = "https://accounts.google.com/o/oauth2/v2/auth?client_id=#{expected_client_id}&redirect_uri=#{expected_redirect_uri}&response_type=code&scope=#{expected_scope}&prompt=select_account"

      oauth_url = google_oauth_service.google_oauth2_url

      expect(oauth_url).to eq(expected_url)
    end
  end
end
