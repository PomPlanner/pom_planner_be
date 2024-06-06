class YoutubeFacade
  def self.search(query_keywords, duration)
    youtube_service = YoutubeService.search(query_keywords, duration)
    youtube_service.map do |video_data|
      YoutubeVideo.new(video_data)
    end
  end
end