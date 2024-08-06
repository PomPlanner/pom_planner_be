class AddEmbedUrlDurationAndDurationCategoryToUserVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :user_videos, :embed_url, :string
    add_column :user_videos, :duration, :string
    add_column :user_videos, :duration_category, :string
  end
end
