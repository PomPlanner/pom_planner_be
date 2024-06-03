require "rails_helper"

RSpec.describe YoutubeVideo do
  before :each do
    @title = "Kyphosis Exercises - 10 Minute Posture Correction Exercises"
    @url = "https://www.youtube.com/watch?v=50PZuFuvAZ8"
    @youtube_video = YoutubeVideo.new(@title, @url)
  end

  it "exists and has attributes" do
    expect(@youtube_video).to be_a(YoutubeVideo)
    expect(@youtube_video.title).to eq("Kyphosis Exercises - 10 Minute Posture Correction Exercises")
    expect(@youtube_video.url).to eq("https://www.youtube.com/watch?v=50PZuFuvAZ8")
  end
end