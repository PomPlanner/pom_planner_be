require 'rails_helper'

RSpec.describe 'YoutubeService', type: :service do
  describe '.search' do
    let(:query_keywords) { 'posture exercises' }
    let(:video_duration) { 'short' }

    it 'returns a list of YoutubeVideo objects when query and length params are entered correctly' do
      VCR.use_cassette('youtube_search') do
        videos = YoutubeService.search(query_keywords, video_duration)
        expect(videos).not_to be_nil
        expect(videos).to be_an(Array)
        expect(videos).to all(be_a(YoutubeVideo))
        expect(videos.first.title).to be_a(String)
        expect(videos.first.title).to eq("PERFECT 5 Minute Posture Routine (FIX YOUR SIT!)")
        expect(videos.first.url).to be_a(String)
        expect(videos.first.url).to eq("https://www.youtube.com/watch?v=u9OQMBPrFgI")
        expect(videos.count).to be_between(1, 25).inclusive
      end
    end

    it 'returns an error message and an empty list if either query or length are not entered' do
      VCR.use_cassette('youtube_search_missing_params') do
         expect { YoutubeService.search(nil, nil) }.to raise_error(StandardError, /YouTube API error: Invalid value at 'video_duration'/)
      end
    end
  end
end