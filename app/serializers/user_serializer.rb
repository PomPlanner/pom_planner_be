class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :image
  # has_many :user_videos
end