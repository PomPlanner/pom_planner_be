require "rails_helper"

RSpec.describe YoutubeVideo do
  before :each do
    @data = {
      id: { videoId: "50PZuFuvAZ8" },
      snippet: { 
        title: "Kyphosis Exercises - 10 Minute Posture Correction Exercises",
        thumbnails: {
          default: {
            url: "https://example.com/default_thumbnail.jpg"
          }
        }
      },
      contentDetails: { duration: "PT10M" }
    }
    @youtube_video = YoutubeVideo.new(@data)
  end
  
  it "exists and has attributes" do
    # require 'pry'; binding.pry
    expect(@youtube_video).to be_a(YoutubeVideo)
    expect(@youtube_video.title).to eq("Kyphosis Exercises - 10 Minute Posture Correction Exercises")
    # expect(@youtube_video.url).to eq("https://www.youtube.com/watch?v=50PZuFuvAZ8")
  end
end