class Api::V1::SessionsController < ApplicationController
# skip_before_action :verify_authenticity_token, only: [:omniauth]
# protect_from_forgery with: :exception

  def google_oauth2
    redirect_to google_oauth2_url, allow_other_host: true
  end
  
  def google_oauth2_url
    client_id = ENV['GOOGLE_CLIENT_ID']
    redirect_uri = CGI.escape('http://localhost:5000/api/v1/auth/google_oauth2/callback')
    scope = CGI.escape('email profile https://www.googleapis.com/auth/calendar.events')
    "https://accounts.google.com/o/oauth2/v2/auth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}"
  end

  def omniauth
    # require 'pry'; binding.pry
    # user = User.from_omniauth(request.env['omniauth.auth'])
    Rails.logger.info "OmniAuth auth info: #{request.env['omniauth.auth'].inspect}"
    Rails.logger.info "OmniAuth callback received: #{request.env['omniauth.auth'].inspect}" # Debug log
    auth_info = request.env['omniauth.auth']
    require 'pry'; binding.pry
    user = User.from_omniauth(auth_info)
    if user.persisted?
      session[:user_id] = user.id 
      redirect_to "http://localhost:3000/auth/google_oauth2/callback?user_id=#{user.id}"
      # redirect_to api_v1_user_path(user)
    else
      redirect_to "http://localhost:3000/", alert: "Authentication failed. Please try again."
      # redirect_to '/', alert: "Authentication failed. Please try again."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

end