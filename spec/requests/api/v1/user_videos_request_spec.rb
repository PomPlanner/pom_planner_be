require "rails_helper"

RSpec.describe "API::V1::UserVideos", type: :request do
  before :each do
    @user1 = create(:user)
    @video1 = create(:user_video, user: @user1)
    @video2 = create(:user_video, user: @user1)
    @video3 = create(:user_video, user: @user1)
  end

  describe "Happy paths" do
    it "saves a new user video favorite" do
      video_params = {
        user_video: {
          title: "New Video",
          url: "http://www.youtube.com"
        }
      }
      
      post api_v1_user_user_videos_path(@user1), params: video_params
      
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['message']).to eq('Video added to favorites')
      expect(@user1.user_videos.count).to eq(4)
    end

    it "removes an existing user video favorite" do
      delete api_v1_user_user_video_path(@user1, @video1)
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('Video removed from favorites')
      expect(@user1.user_videos.count).to eq(2)
    end
  end

  describe "Sad paths" do
    it "returns an error when trying to create a video for a non-existent user" do
      video_params = {
        user_video: {
          title: "New Video",
          url: "http://www.youtube.com"
        }
      }

      post api_v1_user_user_videos_path(-1), params: video_params
      
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('User not found')
    end

    it "returns an error when trying to destroy a non-existent video" do
      delete api_v1_user_user_video_path(@user1, -1)
      
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Video not found')
    end
  end
end