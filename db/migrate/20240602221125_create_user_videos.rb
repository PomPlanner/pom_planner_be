class CreateUserVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :user_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
