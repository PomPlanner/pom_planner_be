class GoogleOauthService
  def google_oauth2_url
    client_id = ENV['GOOGLE_CLIENT_ID']
    redirect_uri = CGI.escape('https://pom-planner-be.herokuapp.com/api/v1/auth/google_oauth2/callback')
    scope = CGI.escape('email profile https://www.googleapis.com/auth/calendar.events')
    
    "https://accounts.google.com/o/oauth2/v2/auth?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code&scope=#{scope}&prompt=select_account"
  end
end
