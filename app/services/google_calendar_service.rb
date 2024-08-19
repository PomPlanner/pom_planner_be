require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'yaml'

class GoogleCalendarService
  include VideoMethods

  APPLICATION_NAME = 'PomPlanner'.freeze
  CREDENTIALS = { client_id: ENV['GOOGLE_CLIENT_ID'], client_secret: ENV['GOOGLE_CLIENT_SECRET'] }
  TOKEN_PATH = 'token.yaml'.freeze
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_EVENTS

  def initialize(user)
    @user = user
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.authorization = user_credentials(user)
  end

  def user_credentials(user)
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
      additional_parameters: { 'access_type' => 'offline' }
    )
   
    credentials.fetch_access_token! if credentials.expired?

    credentials
  end

  def create_event_with_video(summary, description, start_time, video_duration, video_url)
    end_time = start_time + iso8601_duration_to_seconds(video_duration).seconds

    event = Google::Apis::CalendarV3::Event.new(
      summary: summary,
      description: "#{description}\nWatch the video here: #{video_url}\nGet out of your seat!",
      start: Google::Apis::CalendarV3::EventDateTime.new(date_time: start_time),
      end: Google::Apis::CalendarV3::EventDateTime.new(date_time: end_time)
    )

    # Add reminders
    event.reminders = Google::Apis::CalendarV3::Event::Reminders.new(
      use_default: false,
      overrides: [
        Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: 10),
        Google::Apis::CalendarV3::EventReminder.new(reminder_method: 'popup', minutes: 0)
      ]
    )

    @service.insert_event('primary', event)
    event
  end


  def generate_event_link(event_params)
    start_time = event_params[:start_time].to_datetime.utc.iso8601
    video_duration = event_params[:video_duration]
    end_time = calculate_end_time(event_params[:start_time].to_datetime, video_duration).utc.iso8601

    event_description = "Watch this video: #{event_params[:description]}"

    event_link = "https://www.google.com/calendar/render?action=TEMPLATE"
    event_link += "&text=#{URI.encode_www_form_component(event_params[:summary])}"
    event_link += "&details=#{URI.encode_www_form_component(event_description)}"
    event_link += "&dates=#{start_time}/#{end_time}"
    event_link
  end


  private

  def calculate_end_time(start_time, duration)
    total_seconds = iso8601_duration_to_seconds(duration)
    start_time + total_seconds.seconds
  end
end
