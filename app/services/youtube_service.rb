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

    # parse_response(response)
    response = call_api(url, params)
    items = response[:items] || []
    # video_ids = items.map { |item| item[:id][:videoId] }
    # video_details = fetch_video_details(video_ids)
    
    # items.map { |item| YoutubeVideo.new(item, video_details[item[:id][:videoId]]) }
    # Fetch details for each video
    items.map do |item|
      video_id = item.dig(:id, :videoId)
      details = fetch_video_details(video_id)
      YoutubeVideo.new(item, details)
    end
    # require 'pry'; binding.pry
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

  def self.fetch_video_details(video_id)
    url = 'videos'
    params = {
      # part: 'contentDetails',
      # id: video_ids.join(','),
      # key: Rails.application.credentials.google[:api_key]
      part: 'contentDetails',
      id: video_id
    }

    response = call_api(url, params)
    response[:items].first[:contentDetails]

    # details.each_with_object({}) do |item, hash|
    #   video_id = item[:id]
    #   duration = item[:contentDetails][:duration]
    #   hash[video_id] = { duration: duration }
    # end
  end
  
  def self.parse_response(response)
    if response.key?(:error)
      error_message = response[:error][:message]
      raise StandardError, "YouTube API error: #{error_message}"
    else
      items = response[:items] || []
      items.map { |item| YoutubeVideo.new(item) }
    end
  end
end
