class UserVideo < ApplicationRecord
  belongs_to :user
  include VideoMethods

  before_validation :set_duration_category

  validates :title, :url, :embed_url, :duration, :duration_category, presence: true

  private

  def set_duration_category
    if self.duration.present?
      self.duration_category = calculate_duration_category
    end
  end
end
