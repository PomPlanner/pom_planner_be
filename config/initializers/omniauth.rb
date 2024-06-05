# Rails.application.config.middleware.use ActionDispatch::Session::CookieStore, key: '_your_app_session'
# require 'pry'; binding.pry
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email,profile,https://www.googleapis.com/auth/calendar.events',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50,
    access_type: 'offline'
  }
  # require 'pry'; binding.pry
end

# Rails.application.config.middleware.use OmniAuth::Rails::CsrfProtection