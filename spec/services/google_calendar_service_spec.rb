require 'rails_helper'

RSpec.describe GoogleCalendarService do
  let(:user) { double("User", token: "mock_access_token", refresh_token: "mock_refresh_token") }
  let(:google_calendar_service) { GoogleCalendarService.new(user) }

  describe "#user_credentials" do
    it "should refresh the access token if it's expired" do
      # Stub the UserRefreshCredentials instance
      credentials = instance_double(Google::Auth::UserRefreshCredentials)
      allow(Google::Auth::UserRefreshCredentials).to receive(:new).and_return(credentials)
      
      # Simulate expired access token
      allow(credentials).to receive(:expired?).and_return(true)
      
      # Stub the fetch_access_token! method to return a new access token
      allow(credentials).to receive(:fetch_access_token!).and_return("new_access_token")
      
      # Stub the access_token method
      allow(credentials).to receive(:access_token).and_return("new_access_token")
      
      # Stub the refresh_token method
      allow(credentials).to receive(:refresh_token).and_return("mock_refresh_token")
      
      # Invoke the method under test
      refreshed_credentials = google_calendar_service.send(:user_credentials, user)
      
      # Assertions
      expect(refreshed_credentials.access_token).to eq("new_access_token")
      expect(refreshed_credentials.refresh_token).to eq("mock_refresh_token") # Ensure refresh token remains unchanged
    end
  end
end
  # let(:user) { create(:user, token: "ya29.a0AXooCgtD7GM15BWRvOSW5MyOusVky0ZdGqPBRJCbHXyol6n0OVzxu1O205GUvqG-VD7_bVfkIJlnEhIjsgIrWEJtd5lHproew2j8Pf7Rp-k2jnmvJzM84h2M3388wtRvUpNYcOT7z7uwhUqTF4bNg5wZBHWb0yQ9HxHtaCgYKAe8SARESFQHGX2MiKLMdLTWyMpd30CqvkoUO2A0171", refresh_token: "1//04nEwDSiHZP6yCgYIARAAGAQSNwF-L9IrKJMw4DizYumOS5zV43IKF1WvY1WxZ6dYRK_60IhEVH2Z7iluM91jDN0gugvKU4hVCSk") }
  # # let(:mock_credentials) {
  # #   Google::Auth::UserRefreshCredentials.new(
  # #     client_id: ENV['GOOGLE_CLIENT_ID'],
  # #     client_secret: ENV['GOOGLE_CLIENT_SECRET'],
  # #     scope: Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS,
  # #     access_token: 'mock_access_token',
  # #     refresh_token: 'mock_refresh_token'
  # #   )
  # # }

  # before do
  #   # allow_any_instance_of(GoogleCalendarService).to receive(:user_credentials).and_return(mock_credentials)
  #   allow_any_instance_of(GoogleCalendarService).to receive(:user_credentials).and_return(true)
  # end
  # describe '#create_event_with_video' do
  
  #   it 'inserts an event into the Google Calendar' do
  #     service = GoogleCalendarService.new(user)
  #     # Stub the request to return a response with access_token and refresh_token
  #     allow(service).to receive(:user_credentials).and_return(Google::Auth::UserRefreshCredentials.new(
  #       client_id: 'mock_client_id',
  #       client_secret: 'mock_client_secret',
  #       scope: Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS,
  #       refresh_token: 'mock_refresh_token',
  #       access_token: 'mock_access_token',
  #       additional_parameters: { 'access_type' => 'offline' }
  #     ))
      
  #     summary = 'Test Event'
  #     description = 'Test Event Description'
  #     start_time = Time.now
  #     end_time = Time.now + 1.hour
  #     expect(service.create_event_with_video(summary, description, start_time, end_time)).to be_truthy
  #   end
  # end
# end
  # describe '#create_event_with_video' do
  #   it 'inserts an event into the Google Calendar' do
  #     service = GoogleCalendarService.new(user)
  #     summary = 'Test Event'
  #     description = 'Test Event Description'
  #     start_time = Time.now
  #     end_time = Time.now + 1.hour

    
  #     VCR.use_cassette('google_calendar/create_event') do
  #       expect(service.create_event_with_video(summary, description, start_time, end_time)).to be_truthy
  #     end
  #   end
  # end