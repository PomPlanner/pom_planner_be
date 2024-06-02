class API::V1::EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    video_url = params[:video_url]
    @event = OpenStruct.new(summary: "", description: "Get off your chair and listen/watch: #{video_url}", start_time: "", end_time: "")
  end
  
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
    flash.now[:alert] = "Error creating event: #{e.message}"
    render :new
  end
end