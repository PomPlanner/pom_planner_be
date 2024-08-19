class Api::V1::VideosController < ApplicationController
  before_action :set_user

  def index
    @favorite_videos = @user.user_videos
    render json: YoutubeVideoSerializer.new(@favorite_videos).serializable_hash
  end
  
  def create
    # require 'pry'; binding.pry
    @user_video = @user.user_videos.create!(video_params)
    render json: { message: 'Video added to favorites' }, status: :created
  rescue ActiveRecord::RecordNotFound => e
    render json: ErrorSerializer.new(ErrorMessage.new(e.message)).serialize_json, status: :not_found
  end

  def destroy
    @user_video = @user.user_videos.find(params[:id])
    @user_video.destroy
    render json: { message: 'Video removed from favorites' }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: ErrorSerializer.new(ErrorMessage.new(e.message)).serialize_json, status: :not_found
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: ErrorSerializer.new(ErrorMessage.new(e.message)).serialize_json, status: :not_found
  end

  def video_params
    params.require(:user_video).permit(:title, :url, :embed_url, :duration, :duration_category)
  end
end