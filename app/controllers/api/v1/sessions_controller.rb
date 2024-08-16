class Api::V1::SessionsController < ApplicationController
  def google_oauth2
    redirect_to google_oauth2_url, allow_other_host: true
  end
  
  def google_oauth2_url
    client_id = ENV['GOOGLE_CLIENT_ID']
    redirect_uri = CGI.escape('http://localhost:5000/api/v1/auth/google_oauth2/callback')
    scope = CGI.escape('email profile https://www.googleapis.com/auth/calendar.events')
    "https://accounts.google.com/o/oauth2/v2/auth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}&prompt=select_account"
  end

  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      session[:user_id] = user.id 
      redirect_to "http://localhost:3000/auth/google_oauth2/callback?user_id=#{user.id}"
    else
      redirect_to "http://localhost:3000/", alert: "Authentication failed. Please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    render json: { message: "Logged out successfully" }, status: :ok
  rescue => e
    render json: { error: "Failed to log out: #{e.message}" }, status: :internal_server_error
  end
end