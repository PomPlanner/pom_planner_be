require 'rails_helper'
require 'google/apis/calendar_v3'

RSpec.describe GoogleCalendarService do
  let(:user) { double("User", token: "new_access_token", refresh_token: "mock_refresh_token") }
  let(:google_calendar_service) { GoogleCalendarService.new(user) }
  let(:event_data) { { summary: "Test Event", description: "This is a test event", start_time: DateTime.now, end_time: DateTime.now + 1.hour } }
  let(:calendar_service) { instance_double(Google::Apis::CalendarV3::CalendarService) }

  before do
    allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return(calendar_service)
    allow(calendar_service).to receive(:insert_event).and_return(true)
    allow(calendar_service).to receive(:authorization=)
  end

  describe "#create_event_with_video" do
    it "creates an event with the given details" do
      # expect(google_calendar_service.instance_variable_get(:@service)).to receive(:insert_event).with('primary', kind_of(Google::Apis::CalendarV3::Event))
      # google_calendar_service.create_event_with_video(event_data[:summary], event_data[:description], event_data[:start_time], event_data[:end_time])
      expect(google_calendar_service.instance_variable_get(:@service)).to receive(:insert_event).with('primary', kind_of(Google::Apis::CalendarV3::Event)).and_return(true)
      expect(google_calendar_service.create_event_with_video(event_data[:summary], event_data[:description], event_data[:start_time], event_data[:end_time])).to eq(true)
    end
  end
end
  