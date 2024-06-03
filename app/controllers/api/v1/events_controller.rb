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

    google_calendar_service = GoogleCalendarService.new(current_user)

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

  private 

  def authenticate_user!
    unless curent_user.present?
      render json: { error: "Unauthorized action" }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end