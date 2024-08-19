class Api::V1::EventsController < ApplicationController

  def generate_google_calendar_link
    user = User.find(params[:user_id])
    video = user.user_videos.find(params[:video_id])

    start_time = params[:start_time].to_datetime.utc
    video_duration = video.duration

    event_params = {
      summary: params[:summary],
      description: video.url,
      start_time: start_time,
      video_duration: video.duration
    }

    google_calendar_service = GoogleCalendarService.new(user)
    event_link = google_calendar_service.generate_event_link(event_params)

    render json: { event_link: event_link }
  end
end