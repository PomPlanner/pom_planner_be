require "rails_helper"

RSpec.describe UserVideo, type: :model do
  describe "relationships" do
    it { should belong_to(:user).required(true) }
  end

  describe "validations" do
    subject { create(:user_video) }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:embed_url) }
    it { should validate_presence_of(:duration) }

    it "sets duration category during validation, before validation duration category is empty" do
      video = build(:user_video, duration: "PT5M13S", duration_category: nil)
      expect(video.duration_category).to be_nil
      video.valid?
      expect(video.duration_category).to eq("medium")
    end

    it "sets duration_category based on duration" do
      video = build(:user_video, duration: "PT1M")
      video.valid?
      expect(video.duration_category).to eq("short")
    end
  end
end
