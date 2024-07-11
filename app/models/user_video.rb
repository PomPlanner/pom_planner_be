class UserVideo < ApplicationRecord
  belongs_to :user

  validates :title, :url, :embed_url, :duration, :duration_category, presence: true
end