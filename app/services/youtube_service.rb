class YoutubeService
  def self.search(query_keywords, video_duration)
    url = 'search'
    params = {
      part: 'snippet',
      maxResults: 5,
      order: 'relevance',
      type: 'video',
      videoEmbeddable: true,
      q: query_keywords,
      videoDuration: video_duration
    }

    response = call_api(url, params)
    parse_response(response)
  end

  private

  def self.call_api(url, params = {})
    response = connection.get(url) do |request|
      request.params = params
      request.params[:key] = Rails.application.credentials.google[:api_key]
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new('https://www.googleapis.com/youtube/v3')
  end

  def self.parse_response(response)
    response[:items].map do |item|
      YoutubeVideo.new(
        title: item[:snippet][:title],
        url: "https://www.youtube.com/watch?v=#{item[:id][:videoId]}"
      )
    end
  end
end