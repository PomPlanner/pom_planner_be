require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :user_videos }
  end

  describe ".from_omniauth" do
    let(:auth_data) do
      {
        provider: "google_oauth2",
        uid: "123456789",
        info: {
          name: "Nico Shantii",
          email: "nicoshantii@gmail.com",
          image: "https://example.com/nicoshantii.jpg"
        },
        credentials: {
          token: "mock_token",
          refresh_token: "mock_refresh_token"
        }
      }
    end
    
    describe "when user does not already exist" do
      it "creates a new user with valid OAuth data" do
        expect {
          user = User.from_omniauth(auth_data)
          expect(user).to be_persisted
          expect(user.name).to eq("Nico Shantii")
          expect(user.email).to eq("nicoshantii@gmail.com")
          expect(user.image).to eq("https://example.com/nicoshantii.jpg")
          expect(user.token).to eq("mock_token")
          expect(user.refresh_token).to eq("mock_refresh_token")
        }.to change { User.count}.by(1)
      end
    end

    describe "when user already exists" do
      let!(:existing_user) { 
        User.create(uid: "123456789", 
        provider: "google_oauth2", 
        name: "Nico Shantii", 
        email: "nicoshanstrom@gmail.com", 
        password: "password123") 
      }

      it "finds and returns the existing user" do
        expect {
          user = User.from_omniauth(auth_data)
          expect(user).to eq(existing_user)
        }.not_to change { User.count }
      end
    end
  end

  describe ".generate_secure_password" do
    it "generates a secure random password" do
      password = User.send(:generate_secure_password)
      expect(password).to be_a(String)
      expect(password.length).to eq(30)
    end
  end
end
