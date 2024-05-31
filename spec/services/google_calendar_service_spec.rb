require 'rails_helper'

RSpec.describe GoogleCalendarService do
  let(:user) { create(:user) }

  # before do
  #   # Mock OAuth token retrieval
  #   allow_any_instance_of(GoogleCalendarService).to receive(:user_credentials).and_return(true)
  # end

  describe '#create_event_with_video' do
  
    it 'inserts an event into the Google Calendar', vcr: { cassette_name: 'google_calendar_event_insertion' } do
      service = GoogleCalendarService.new(user)
      # require 'pry'; binding.pry
      
      summary = 'Test Event'
      description = 'Test Event Description'
      start_time = Time.now
      end_time = Time.now + 1.hour
      expect(service.create_event_with_video(summary, description, start_time, end_time)).to be_truthy
      # event_summary = 'Test Event'
      # event_description = 'Test event description'
      # start_time = Time.now
      # end_time = start_time + 1.hour
      
      # event = double # Mocking a Google Calendar event
      # allow(Google::Apis::CalendarV3::Event).to receive(:new).and_return(event)
      # expect(event).to receive(:summary=).with(event_summary)
      # expect(event).to receive(:description=).with(event_description)
      # # More expectations for event creation...
      
      # expect(service.create_event_with_video(event_summary, event_description, start_time, end_time)).to be_truthy
    end
  end
end