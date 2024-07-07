class YoutubeVideoSerializer
  include JSONAPI::Serializer

  set_type :youtube_video
  attributes :title, :url

  attribute :embed_url do |video|
    "https://www.youtube.com/embed/#{video.id}"
  end

  attribute :duration do |video|
    video.formatted_duration
  end

  attribute :category do |video|
    video.category
  end
end
