class User < ApplicationRecord
  has_many :user_videos
  
  has_secure_password

  # def self.from_omniauth(auth)
  #   # require 'pry'; binding.pry
  #   user = User.find_or_create_by(uid: auth.uid, provider: auth.provider) do |u|
  #     u.name = auth.info.name
  #     u.image = auth.info.image
  #     u.email = auth.info.email
  #     u.access_token = auth.credentials.token
  #     u.refresh_token = auth.credentials.refresh_token
  #     u.password = SecureRandom.hex(15)
  #   end
  #   user
  # end
  def self.from_omniauth(response)
    Rails.logger.info "OmniAuth response: #{response.inspect}"
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |user|
      user.name = response[:info][:name]
      user.image = response[:info][:image]
      user.email = response[:info][:email]
      user.access_token = response[:credentials][:token] # Store access token
      user.refresh_token = response[:credentials][:refresh_token] # Store refresh token
      user.password = SecureRandom.hex(15)
    end
  end
end
