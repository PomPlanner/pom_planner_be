require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

TOKEN_STORE_PATH = 'config/google_tokens/token.yaml'
client_id = ENV['GOOGLE_CLIENT_ID']
SCOPE = 'https://www.googleapis.com/auth/calendar.events'

# Ensure the directory exists
FileUtils.mkdir_p(File.dirname(TOKEN_STORE_PATH))

# Set up token store
token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_STORE_PATH)

# Use the token store in your authorization setup
authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
