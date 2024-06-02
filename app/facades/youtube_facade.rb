class YoutubeFacade
  def self.search(query_keywords, duration)
    youtube_service = YoutubeService.search(query_keywords, duration)

  end
end