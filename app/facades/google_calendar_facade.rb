class GoogleCalendarFacade
  def initialize(user)
    @calendar_service = GoogleCalendarService.new(user)
  end

  def get_event_link(video_url)
    @calendar_service.generate_event_link(video_url)
  end
end
