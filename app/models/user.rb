class User < ApplicationRecord
  has_secure_password

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
      u.name = response[:info][:name]
      u.image = response[:info][:image]
      u.email = response[:info][:email]
      u.access_token = response[:credentials][:token] # Store access token
      u.refresh_token = response[:credentials][:refresh_token] # Store refresh token
      u.password = SecureRandom.hex(15) # Generate a random password
    end
  end
end
