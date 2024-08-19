require 'rails_helper'
require 'google/apis/calendar_v3'

RSpec.describe GoogleCalendarService do
  let(:user) { double("User", token: "new_access_token", refresh_token: "mock_refresh_token") }
  let(:google_calendar_service) { GoogleCalendarService.new(user) }
  let(:calendar_service) { instance_double(Google::Apis::CalendarV3::CalendarService) }
  let(:start_time) { DateTime.now }
  let(:video_url) { "https://www.youtube.com/watch?v=u9OQMBPrFgI" }
  let(:video_duration) { "PT5M13S" }

  before do
    allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return(calendar_service)
    allow(calendar_service).to receive(:insert_event).and_return(true)
    allow(calendar_service).to receive(:authorization=)
  end

  describe "#create_event_with_video" do
    it "creates an event with the correct end time based on video duration" do
      end_time = start_time + 5.minutes + 13.seconds
      expect(calendar_service).to receive(:insert_event).with('primary', kind_of(Google::Apis::CalendarV3::Event)).and_return(true)

      event = google_calendar_service.create_event_with_video(
        "Test Event",
        "This is a test event",
        start_time,
        video_duration,
        video_url
      )

      expect(event.start.date_time).to eq(start_time)
      expect(event.end.date_time).to eq(end_time)
      expect(event.description).to include(video_url)
      expect(event.description).to include("Get out of your seat!")
    end


    it "raises an error if the API call fails" do
      allow(calendar_service).to receive(:insert_event).and_raise(Google::Apis::ServerError.new("Server error"))

      expect {
        google_calendar_service.create_event_with_video(
          "Test Event",
          "This is a test event",
          start_time,
          video_duration,
          video_url
        )
      }.to raise_error(Google::Apis::ServerError)
    end
  end

  describe "#generate_event_link" do
    let(:event_params) do
      {
        summary: "Test Event",
        description: video_url,
        start_time: start_time.to_s,
        video_duration: video_duration
      }
    end

    it "generates a correct event link" do
      end_time = start_time + 5.minutes + 13.seconds
      start_time_rfc3339 = start_time.rfc3339
      end_time_rfc3339 = end_time.rfc3339

      event_link = google_calendar_service.generate_event_link(event_params)

      expected_link = "https://www.google.com/calendar/render?action=TEMPLATE"
      expected_link += "&text=Test+Event"
      expected_link += "&details=Watch+this+video%3A+https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3Du9OQMBPrFgI"
      expected_link += "&dates=#{start_time_rfc3339}/#{end_time_rfc3339}"

      expect(event_link).to eq(expected_link)
    end
  end
end
