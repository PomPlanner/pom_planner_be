require "rails_helper"

RSpec.describe "API::V1::UserVideos", type: :request do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @video1 = create(:user_video, user: @user1)
    @video2 = create(:user_video, user: @user1)
  end

  describe "Happy paths" do
    it "retrieves a list of favorite videos" do
      get api_v1_user_videos_path(@user1)

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      
      expect(parsed_response).to be_a(Hash)
      expect(parsed_response["data"]).to be_an(Array)
      expect(parsed_response["data"].length).to eq(2)
      expect(parsed_response["data"][0]["attributes"]["title"]).to eq(@video1.title)
      expect(parsed_response["data"][1]["attributes"]["title"]).to eq(@video2.title)
    end
    
    it "returns an empty array if the user does not have any favorite videos" do
      get api_v1_user_videos_path(@user2)

      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to be_a(Hash)
      expect(parsed_response["data"]).to be_an(Array)
      expect(parsed_response["data"]).to be_empty
      expect(parsed_response["data"].length).to eq(0)
    end
    
    it "saves a new user video favorite" do
      video_params = {
        user_video: {
          title: "New Video",
          url: "http://www.youtube.com",
          embed_url: "http://www.youtube.com/embed/test",
          duration: "PT4M13S",
          duration_category: "short"
        }
      }
      
      post api_v1_user_videos_path(@user1), params: video_params
  
      expect(response).to have_http_status(:created)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq('Video added to favorites')
      expect(@user1.user_videos.count).to eq(3)
    end

    it "removes an existing user video favorite" do
      delete api_v1_user_video_path(@user1, @video1)
      
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['message']).to eq('Video removed from favorites')
      expect(@user1.user_videos.count).to eq(1)
    end
  end

  describe "Sad paths" do
    it "returns an error when trying to create a video with invalid data" do
      invalid_video_params = {
        user_video: {
          title: "", # Invalid title, assuming there's a presence validation
          url: "http://www.youtube.com",
          embed_url: "http://www.youtube.com/embed/test",
          duration: "PT4M13S",
          duration_category: "short"
        }
      }
      
      post api_v1_user_videos_path(@user1), params: invalid_video_params
      
      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors'].first['detail']).to match(/Validation failed/)
    end

    it "returns an error when trying to create a video for a non-existent user" do
      video_params = {
        user_video: {
          title: "New Video",
          url: "http://www.youtube.com",
          embed_url: "http://www.youtube.com/embed/test",
          duration: "PT4M13S",
          duration_category: "short"
        }
      }

      post api_v1_user_videos_path(-1), params: video_params
      
      expect(response).to have_http_status(:not_found)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors'].first['detail']).to eq("Couldn't find User with 'id'=-1")
    end

    it "returns an error when trying to destroy a non-existent video" do
      delete api_v1_user_video_path(@user1, -1)
      
      expect(response).to have_http_status(:not_found)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['errors']).to eq([{"detail"=> "Couldn't find UserVideo with 'id'=-1 [WHERE \"user_videos\".\"user_id\" = $1]"}])
    end
  end
end