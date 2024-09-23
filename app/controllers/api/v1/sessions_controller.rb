class Api::V1::SessionsController < ApplicationController
  def google_oauth2
    oauth_service = GoogleOauthService.new
    redirect_to oauth_service.google_oauth2_url, allow_other_host: true
  end

  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      session[:user_id] = user.id 
      redirect_to "https://pom-planner.herokuapp.com/auth/google_oauth2/callback?user_id=#{user.id}"
    else
      redirect_to "https://pom-planner.herokuapp.com/", alert: "Authentication failed. Please try again."
    end
  rescue => e
    render json: { error: "Authentication error: #{e.message}" }, status: :internal_server_error
  end

  def destroy
    session[:user_id] = nil
    reset_session
    render json: { message: "Logged out successfully" }, status: :ok
  rescue => e
    render json: { error: "Failed to log out: #{e.message}" }, status: :internal_server_error
  end
end