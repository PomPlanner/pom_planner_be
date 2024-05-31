class YoutubeService					
  def self.call_db(url, params = {})		
    response = connection.get(url) do |request| 		
      request.params = params		
      request.params[:key] = Rails.application.credentials.google[:api_key]		
    end		
    JSON.parse(response.body, symbolize_names: true)		
  end		
      
  private		
      
  def self.connection		
    Faraday.new('https://www.googleapis.com/youtube/v3')		
  end
end