class YoutubeService
  def self.search(query_keywords, video_duration)
    url = 'search'
    params = {
      part: 'snippet',
      maxResults: 25,
      order: 'relevance',
      type: 'video',
      videoEmbeddable: true,
      q: query_keywords,
      videoDuration: video_duration
    }

    response = call_api(url, params)
    # require 'pry'; binding.pry
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
    # require 'pry'; binding.pry
    # if response.key?(:error)
    #   error_message = response[:error][:message]
    #   raise StandardError, "YouTube API error: #{error_message}"
    # else
    #   items = response[:items] || []
    #   items.map do |item|
    #     YoutubeVideo.new(
    #       item[:snippet][:title],
    #       "https://www.youtube.com/watch?v=#{item[:id][:videoId]}"
    #     )
    #   end
    # end
    if response.key?(:error)
      error_message = response[:error][:message]
      raise StandardError, "YouTube API error: #{error_message}"
    else
      items = response[:items] || []
      items.map do |item|
        YoutubeVideo.new(
          id: { videoId: item[:id][:videoId] },
          snippet: item[:snippet],
          contentDetails: item[:contentDetails], # Add this line to include contentDetails
          title: item[:snippet][:title],
          url: "https://www.youtube.com/watch?v=#{item[:id][:videoId]}",
          duration: item[:contentDetails]&.dig(:duration), # Safely access duration if available
          thumbnail_url: item[:snippet][:thumbnails][:default][:url]
        )
      end
    end
  end
end
