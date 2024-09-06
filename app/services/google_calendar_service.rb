require 'google/apis/calendar_v3'
require 'googleauth'

class GoogleCalendarService
  APPLICATION_NAME = 'PomPlanner'.freeze
  CREDENTIALS = { client_id: ENV['GOOGLE_CLIENT_ID'], client_secret: ENV['GOOGLE_CLIENT_SECRET'] }
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS

  def initialize(user)
    @user = user
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.authorization = user_credentials(user)
  end

  def user_credentials(user)
    client_id = CREDENTIALS[:client_id]
    client_secret = CREDENTIALS[:client_secret]

    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: client_id,
      client_secret: client_secret,
      scope: SCOPE,
      refresh_token: @user.refresh_token,
      access_token: @user.token
    )

    credentials.fetch_access_token! if credentials.expired?
    credentials
  end

  def generate_event_link(video_url)
    event_link = "https://www.google.com/calendar/render?action=TEMPLATE"
    event_link += "&text=PomPlaner+Event"
    event_link += "&details=Watch+this+video%3A+#{CGI.escape(video_url)}"
    event_link
  end
end
