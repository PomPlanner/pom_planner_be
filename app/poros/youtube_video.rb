class YoutubeVideo
  attr_reader :id, :title, :url, :duration, :embed_url

  def initialize(data, details = {})
    # require 'pry'; binding.pry
    @id = data[:id][:videoId]
    @title = data[:snippet][:title]
    @url = "https://www.youtube.com/watch?v=#{@id}"
    @duration = details[:duration]
    @embed_url = "https://www.youtube.com/embed/#{@id}"
  end

  def formatted_duration
    iso8601_duration_to_human_readable(@duration)
  end

  def duration_category
    total_seconds = iso8601_duration_to_seconds(@duration)
    if total_seconds < 4 * 60
      'short'
    else total_seconds <= 20 * 60
      'medium'
    end
  end

  private

  def iso8601_duration_to_human_readable(duration)
    match = /PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/.match(duration)
    hours = match[1].to_i
    minutes = match[2].to_i
    seconds = match[3].to_i

    result = []
    result << "#{hours} hours" if hours > 0
    result << "#{minutes} minutes" if minutes > 0
    result << "#{seconds} seconds" if seconds > 0
    result.join(", ")
  end

  def iso8601_duration_to_seconds(duration)
    match = /PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?/.match(duration)
    hours = match[1].to_i
    minutes = match[2].to_i
    seconds = match[3].to_i
    (hours * 3600) + (minutes * 60) + seconds
  end
end
