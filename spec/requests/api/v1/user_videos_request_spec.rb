require "rails_helper"

RSpec.describe "API::V1::UserVideos", type: :request do
  before :each do
    @user1 = create(:user)
    @video1 = create(:user_video, user: @user1)
    @video2 = create(:user_video, user: @user1)
    @video3 = create(:user_video, user: @user1)
  end

  describe "Happy paths" do
    it "" do
      
    end
  end
end