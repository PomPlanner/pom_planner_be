class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_secure_password

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |user|
      user.name = response[:info][:name]
      user.image = response[:info][:image]
      user.email = response[:info][:email]
      user.token = response[:credentials][:token]
      user.refresh_token = response[:credentials][:refresh_token]
      user.password = generate_secure_password
    end
  end

  private

  def self.generate_secure_password
    SecureRandom.hex(15)
  end
end
