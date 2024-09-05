class YoutubeVideo
  attr_reader :id, :title, :url, :duration, :embed_url, :duration_category
  include VideoMethods

  def initialize(data, details = {})
    @id = data.dig(:id, :videoId)
    @title = data.dig(:snippet, :title)
    @url = "https://www.youtube.com/watch?v=#{@id}"
    @duration = details[:duration]
    @embed_url = "https://www.youtube.com/embed/#{@id}"
    @duration_category = calculate_duration_category if @duration.present?
  end
end