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
      }
    }
    @details = { duration: "PT10M" }
    @youtube_video = YoutubeVideo.new(@data, @details)
  end
  
  it "exists and has attributes" do
    expect(@youtube_video).to be_a(YoutubeVideo)
    expect(@youtube_video.title).to eq("Kyphosis Exercises - 10 Minute Posture Correction Exercises")
    expect(@youtube_video.url).to eq("https://www.youtube.com/watch?v=50PZuFuvAZ8")
    expect(@youtube_video.duration_category).to eq("medium")
    expect(@youtube_video.duration).to eq("PT10M")
    expect(@youtube_video.embed_url).to eq("https://www.youtube.com/embed/50PZuFuvAZ8")
  end

  describe "#formatted_duration" do
    it "formats ISO8601 duration into a human-readable format" do
      expect(@youtube_video.formatted_duration).to eq("10 minutes")
    end

    it "returns the duration as-is if it's already in human-readable format" do
      non_iso_duration = { duration: "10 minutes" }
      video = YoutubeVideo.new(@data, non_iso_duration)
      expect(video.formatted_duration).to eq("10 minutes")
    end
  end

  describe "#calculate_duration_category" do
    it "categorizes medium videos correctly" do
      expect(@youtube_video.calculate_duration_category).to eq("medium")
    end

    it "categorizes short videos correctly" do
      short_video_details = { duration: "PT3M" }
      short_video = YoutubeVideo.new(@data, short_video_details)
      expect(short_video.calculate_duration_category).to eq("short")
    end

    it "does not calculate duration category if it's already set" do
      existing_duration_category = { duration: "8 minutes", duration_category: "medium" }
      video = YoutubeVideo.new(@data, existing_duration_category)
      expect(video.duration_category).to eq("medium")
    end
  end

  describe "#iso8601_duration_to_seconds" do
    it "parses ISO8601 format for hours, minutes, and seconds correctly" do
      details = { duration: "PT1H20M30S" }
      video = YoutubeVideo.new(@data, details)
      
      expect(video.send(:iso8601_duration_to_seconds, "PT1H20M30S")).to eq(4830)
    end

    it "parses ISO8601 format for minutes and seconds correctly" do
      details = { duration: "PT20M30S" }
      video = YoutubeVideo.new(@data, details)
      
      expect(video.send(:iso8601_duration_to_seconds, "PT20M30S")).to eq(1230)
    end

    it "parses ISO8601 format for seconds correctly" do
      details = { duration: "PT45S" }
      video = YoutubeVideo.new(@data, details)
      
      expect(video.send(:iso8601_duration_to_seconds, "PT45S")).to eq(45)
    end
  end
end
