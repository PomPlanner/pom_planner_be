require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'yaml'

class GoogleCalendarService
  APPLICATION_NAME = 'PomPlanner'.freeze
  CREDENTIALS = { client_id: ENV['GOOGLE_CLIENT_ID'], client_secret: ENV['GOOGLE_CLIENT_SECRET'] }
  TOKEN_PATH = 'token.yaml'.freeze
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS

  def initialize(user)
    @user = user
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = user_credentials(user)
    # require 'pry'; binding.pry
  end

  def user_credentials(user)
    # require 'pry'; binding.pry
    client_id = CREDENTIALS[:client_id]
    client_secret = CREDENTIALS[:client_secret]
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    
    access_token = @user.token
    refresh_token = @user.refresh_token
    
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: client_id,
      client_secret: client_secret,
      scope: SCOPE,
      refresh_token: refresh_token,
      access_token: access_token,
      additional_parameters: { 'access_type' => 'offline' } # Include this if you want to obtain a refresh token
    )
   
    credentials.fetch_access_token! if credentials.expired?

    credentials
  end

  def create_event_with_video(summary, description, start_time, end_time)
    event = Google::Apis::CalendarV3::Event.new(
      summary: summary,
      description: description,
      start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time),
      end: Google::Apis::CalendarV3::EventDateTime.new(date_time: end_time)
    )

    # Add reminders
    event.reminders = Google::Apis::CalendarV3::Event::Reminders.new(
      use_default: false,
      overrides: [
        Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: 10),
        Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: 0), # At start
        Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: -10) # At end
      ]
    )

    @service.insert_event('primary', event)
  end
end