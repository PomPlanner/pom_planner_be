Rails.application.config.middleware.use ActionDispatch::Session::CookieStore, key: '_your_app_session'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email,profile',
    prompt: 'select_account',
    access_type: 'offline'
  }
end

# Rails.application.config.middleware.use OmniAuth::Rails::CsrfProtection