class Api::V1::EventsController < ApplicationController
  def generate_google_calendar_link
    user = User.find(params[:user_id])
    video = user.user_videos.find(params[:video_id])

    facade = GoogleCalendarFacade.new(user)
    event_link = facade.get_event_link(video.url)

    render json: { event_link: event_link }
  rescue StandardError => e
    Rails.logger.error("Error generating Google Calendar link: #{e.message}")
    render json: { error: 'Failed to generate event link' }, status: :internal_server_error
  end
end
