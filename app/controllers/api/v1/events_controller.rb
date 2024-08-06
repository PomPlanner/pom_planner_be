class Api::V1::EventsController < ApplicationController
  def generate_google_calendar_link
    user = User.find(params[:user_id])
    video = user.user_videos.find(params[:video_id])

    start_time = params[:start_time]
    end_time = params[:end_time]

    event_params = {
      summary: params[:summary],
      description: "Watch this video: #{video.url}",
      start_time: start_time,
      end_time: end_time
    }

    google_calendar_service = GoogleCalendarService.new(user)
    event_link = google_calendar_service.generate_event_link(event_params)

    render json: { event_link: event_link }
  end
  # before_action :set_user

  # def new
  #   @video = Video.find(params[:video_id])
  # end
  
  # def create
  #   video_id = params[:video_id]
  #   event_date = params[:event_date]
  #   start_time = params[:start_time]
  #   end_time = params[:end_time]
  #   video_title = "Pom Event: #{@video.title}"
  #   video_url = user_video_url(@user, video_id)

  #   start_date_time = DateTime.parse("#{event_date} #{start_time}").iso8601
  #   end_date_time = DateTime.parse("#{event_date} #{end_time}").iso8601
  #   # google_calendar_service = GoogleCalendarService.new(@user)

  #   # google_calendar_service.create_event_with_video(
  #   #   start_time,
  #   #   end_time,
  #   #   summary,
  #   #   description,
  #   #   video_url
  #   # )
  #   calendar_url = "https://www.google.com/calendar/render?action=TEMPLATE&text=#{CGI.escape(video_title)}&dates=#{start_date_time.gsub(/-|:|\.\d+/, '')}/#{end_date_time.gsub(/-|:|\.\d+/, '')}&details=#{CGI.escape("Watch the video here: #{video_url}")}&sf=true&output=xml"

  #   redirect_to calendar_url
  # #   render json: { message: 'Event created successfully' }, status: :ok
  # # rescue Google::Apis::AuthorizationError => e
  # #   render json: { error: 'Authorization error', message: e.message }, status: :unauthorized
  # # rescue StandardError => e
  # #   render json: { error: 'An error occurred', message: e.message }, status: :unprocessable_entity
  # end

  # private

  # def set_user
  #   @user = User.find(params[:user_id])
  # rescue ActiveRecord::RecordNotFound
  #   render json: { error: 'User not found' }, status: :not_found
  # end
  # # def authenticate_user!
  # #   unless curent_user.present?
  # #     render json: { error: "Unauthorized action" }, status: :unauthorized
  # #   end
  # # end

  # # def current_user
  # #   @current_user ||= User.find_by(id: session[:user_id])
  # # end
end