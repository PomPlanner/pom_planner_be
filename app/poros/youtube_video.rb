class YoutubeVideo
  attr_reader :id, :title, :url, :duration, :thumbnail_url

  def initialize(data)
    # require 'pry'; binding.pry
    @id = data[:id][:videoId]
    @title = data[:snippet][:title]
    @url = "https://www.youtube.com/watch?v=#{@id}"
    # @duration = data[:contentDetails][:duration]
    @thumbnail_url = data[:snippet][:thumbnails][:default][:url]
  end
end
