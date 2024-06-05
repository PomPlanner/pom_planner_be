class User < ApplicationRecord
  has_many :user_videos
  has_secure_password

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |user|
      user.name = response[:info][:name]
      user.image = response[:info][:image]
      user.email = response[:info][:email]
      user.token = response[:credentials][:token] # Store access token
      user.refresh_token = response[:credentials][:refresh_token] # Store refresh token
      user.password = SecureRandom.hex(15)
    end
  end
end
