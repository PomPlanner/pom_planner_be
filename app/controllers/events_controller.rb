class EventsController < ApplicationController
  def create
    summary = params[:summary]
    video_url = params[:video_url]
    description = "#{params[:description]}\n\nWatch the video: #{video_url}"
    start_time = params[:start_time]
    end_time = params[:end_time]

    user = User.find(session[:user_id])
    google_calendar_service = GoogleCalendarService.new(user)

    google_calendar_service.create_event_with_video(
      summary,
      description,
      start_time,
      end_time
    )

    render json: { message: 'Event created successfully' }, status: :ok
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end