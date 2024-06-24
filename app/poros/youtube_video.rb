class YoutubeVideo
  attr_reader :id, :title, :url, :duration, :embed_url

  def initialize(data)
    # require 'pry'; binding.pry
    @id = data[:id][:videoId]
    @title = data[:snippet][:title]
    @url = "https://www.youtube.com/watch?v=#{@id}"
    # @duration = data[:contentDetails][:duration]
    @embed_url = "https://www.youtube.com/embed/#{@id}"
  end
end
