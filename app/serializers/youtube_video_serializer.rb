class YoutubeVideoSerializer
  include JSONAPI::Serializer

  set_type :youtube_video
  attributes :title, :url, :embed_url, :duration, :duration_category

  attribute :id do |video|
    video.id
  end
  
  attribute :embed_url do |video|
    video.embed_url
  end

  attribute :duration do |video|
    video.formatted_duration
  end

  attribute :duration_category do |video|
    video.duration_category
  end
end
