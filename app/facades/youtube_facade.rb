class YoutubeFacade
  def self.search(query_keywords, duration)
    YoutubeService.search(query_keywords, duration)
  end
end
