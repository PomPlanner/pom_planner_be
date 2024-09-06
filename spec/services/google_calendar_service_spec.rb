require 'rails_helper'
require 'google/apis/calendar_v3'

RSpec.describe GoogleCalendarService do
  let(:user) { double("User", token: "new_access_token", refresh_token: "mock_refresh_token") }
  let(:google_calendar_service) { GoogleCalendarService.new(user) }
  let(:video_url) { "https://www.youtube.com/watch?v=u9OQMBPrFgI" }
  
  describe "#user_credentials" do
    it "returns valid credentials for the user" do
      credentials = google_calendar_service.user_credentials(user)

      expect(credentials.client_id).to eq(ENV['GOOGLE_CLIENT_ID'])
      expect(credentials.client_secret).to eq(ENV['GOOGLE_CLIENT_SECRET'])
      expect(credentials.refresh_token).to eq("mock_refresh_token")
      expect(credentials.access_token).to eq("new_access_token")
    end
  end

  describe "#generate_event_link" do
    it "generates a correct event link with summary and video link" do
      event_link = google_calendar_service.generate_event_link(video_url)

      expected_link = "https://www.google.com/calendar/render?action=TEMPLATE"
      expected_link += "&text=PomPlaner+Event"
      expected_link += "&details=Watch+this+video%3A+https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3Du9OQMBPrFgI"
      
      expect(event_link).to eq(expected_link)
    end
  end
end

